function out = display_obs_noise_plot(n_samples, noise_lower_bound,noise_upper_bound ,data, memory, hazard)
out = [];
surprisals = zeros(n_samples,1);
noises = linspace(noise_lower_bound, noise_upper_bound, n_samples);
params = [];
params.distribution = 'gaussian';
params.D = 1;
params.memory = memory;
params.hazard = hazard;
params.prior = estimate_suffstat(std(data)*randn(1000,1),params);

for i = 1:n_samples
    params.obsnz = noises(i);
    out = run_DREX_model(data,params);
    surprisal = sum(out.surprisal); 
    surprisals(i) = surprisal; 
end 
out = [noises',surprisals];
noises = out(:,1);
surprisals = out(:,2);
figure;
plot(noises,surprisals);
title('Surprisal observational noise plot ');
ylabel('Sum of Surprisal');
xlabel('observational noise');
end