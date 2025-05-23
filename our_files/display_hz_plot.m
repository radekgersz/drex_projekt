function out = display_hz_plot(n_samples, hazard_lower_bound, hazard_upper_bound, data,memory,obs_noise)
out = [];
surprisals = zeros(n_samples,1);
hazards = linspace(hazard_lower_bound, hazard_upper_bound, n_samples);
params = [];
params.distribution = 'gaussian';
params.D = 1;
params.memory = memory;
params.obsnz = obs_noise;
params.prior = estimate_suffstat(std(data)*randn(1000,1),params);

for i = 1:n_samples
    params.hazard = hazards(i);
    out = run_DREX_model(data,params);
    surprisal = sum(out.surprisal); 
    surprisals(i) = surprisal; 
end 
out = [hazards',surprisals];
hazards = out(:,1);
surprisals = out(:,2);
figure;
plot(hazards,surprisals);
title('Surprisal hazard rate plot ');
ylabel('Sum of Surprisal');
xlabel('hazard rate');
end