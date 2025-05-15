function out = display_memory_plot(n_samples, memory_lower_bound,memory_upper_bound ,data,obs_noise,hazard)
out = [];
surprisals = zeros(n_samples,1);
memories = round(linspace(memory_lower_bound, memory_upper_bound, n_samples));
params = [];
params.distribution = 'gaussian';
params.D = 1;
params.obsnz = obs_noise;
params.hazard = hazard;
params.prior = estimate_suffstat(std(data)*randn(1000,1),params);

for i = 1:n_samples
    params.memory = memories(i);
    out = run_DREX_model(data,params);
    surprisal = sum(out.surprisal); 
    surprisals(i) = surprisal; 
end 
out = [memories',surprisals];
memories = out(:,1);
surprisals = out(:,2);
figure;
plot(memories,surprisals);
title('Surprisal memory plot ');
ylabel('Sum of Surprisal');
xlabel('memory');
end
