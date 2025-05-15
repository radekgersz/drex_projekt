function out = display_hazard_noise_plot(n_samples, data, hazard_lower_bound, hazard_upper_bound, noise_lower_bound, noise_upper_bound)
    out = zeros(n_samples, n_samples, 3);
    noises = linspace(noise_lower_bound, noise_upper_bound, n_samples);
    hazards = linspace(hazard_lower_bound, hazard_upper_bound, n_samples);
    
    params = [];
    params.distribution = 'gaussian';
    params.D = 1;
    params.prior = estimate_suffstat(std(data) * randn(1000, 1), params);
 
    for i = 1:n_samples
        params.hazard = hazards(i);
        for j = 1:n_samples
            params.obsnz = noises(j);
            result = run_DREX_model(data,params);
            surprisal = sum(result.surprisal);
            out(i, j, 1) = params.hazard;
            out(i, j, 2) = params.obsnz;
            out(i, j, 3) = surprisal;
        end
    end
    hazards = out(:, :, 1);
    noises = out(:, :, 2);
    surprisals = out(:, :, 3);
    figure;	
    surf(hazards, noises, surprisals);
    title('3d plot of suprisal depending on hazard and noise');
    xlabel('Hazard');
    ylabel('noise');
    zlabel('sum of surprisal');
end