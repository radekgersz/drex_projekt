function out = display_hazard_memory_plot(n_samples, data, hazard_lower_bound, hazard_upper_bound, memory_lower_bound, memory_upper_bound)
    out = zeros(n_samples, n_samples, 3);
    memories = linspace(memory_lower_bound, memory_upper_bound, n_samples);
    hazards = linspace(hazard_lower_bound, hazard_upper_bound, n_samples);
    params = [];
    params.distribution = 'gaussian';
    params.D = 1;
    params.prior = estimate_suffstat(std(data) * randn(1000, 1), params);
    for i = 1:n_samples
        params.hazard = hazards(i);
        for j = 1:n_samples
            params.memory = memories(j);
            out = run_DREX_model(data,params);
            surprisal = sum(out.surprisal);
            out(i, j, 1) = params.hazard;
            out(i, j, 2) = params.memories;
            out(i, j, 3) = surprisal;
        end
    end
    hazards = result(:, :, 1);
    memories = result(:, :, 2);
    surprisals = result(:, :, 3);
    figure;	
    surf(hazards, memories, surprisals);
    title('3d plot of suprisal depending on hazard and memory');
    xlabel('Hazard');
    ylabel('memory');
    zlabel('sum of surprisal');
end