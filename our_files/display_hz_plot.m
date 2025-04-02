function out = display_hz_plot(n_samples, base_hazard, data, memory)
out = [];
surprisals = zeros(n_samples,1);
hazards = zeros(n_samples,1);
params = [];
params.distribution = 'gaussian';
params.D = 1;
params.memory = memory;
params.hazard = base_hazard;
params.prior = estimate_suffstat(std(data)*randn(1000,1),params);

for i = 1:n_samples
    out = run_DREX_model(data,params);
    surprisal = mean(out.surprisal); 
    surprisals(i) = surprisal;
    hazards(i) = params.hazard; 
    params.hazard = params.hazard + (1-base_hazard)/(n_samples);
    
end 
out = [hazards,surprisals];
end