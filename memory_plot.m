function out = memory_plot(n_samples, memory_lower_bound,memory_upper_bound,data,hazard)
out = [];
surprisals = zeros(n_samples,1);
noises = linspace(memory_lower_bound, memory_upper_bound, n_samples);
params = [];
params.distribution = 'gaussian';
params.D = 1;
params.hazard = hazard;
params.prior = estimate_suffstat(std(data)*randn(1000,1),params);

for i = 1:n_samples
    params.memory = int8(noises(i));
    out = run_DREX_model(data,params);
    surprisal = sum(out.surprisal); 
    surprisals(i) = surprisal; 

    
end 
out = [noises',surprisals];
end