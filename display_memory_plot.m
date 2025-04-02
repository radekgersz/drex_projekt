function out = display_memory_plot(n_samples, hazard, data)
out = [];
surprisals = zeros(n_samples,1);
memory = ones(n_samples,1);
params = [];
params.distribution = 'gaussian';
params.D = 1;
params.memory = 2;
params.hazard = hazard;
params.prior = estimate_suffstat(std(data)*randn(1000,1),params);

for i = 1:n_samples
    out = run_DREX_model(data,params);
    surprisal = std(out.surprisal); 
    surprisals(i) = surprisal;
    memory(i) = params.memory; 
    params.memory = params.memory + 1;
    
end 
out = [memory,surprisals];
end
