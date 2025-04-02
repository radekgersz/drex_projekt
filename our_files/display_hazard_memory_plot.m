function out = display_hazard_memory_plot(n_samples, base_hazard, data, base_memory)
    out = zeros(n_samples, n_samples, 3); % Preallocate output matrix
    params = [];
    params.distribution = 'gaussian';
    params.D = 1;
    params.prior = estimate_suffstat(std(data) * randn(1000, 1), params);
    
    hazard_step = (1 - base_hazard) / n_samples;
    memory_step = 1; % Increment memory linearly
    
    for i = 1:n_samples
        for j = 1:n_samples
            params.hazard = base_hazard + (i - 1) * hazard_step;
            params.memory = base_memory + (j - 1) * memory_step;
            
            out_model = run_DREX_model(data, params);
            surprisal = std(out_model.surprisal);
            
            out(i, j, 1) = params.hazard;
            out(i, j, 2) = params.memory;
            out(i, j, 3) = surprisal;
        end
    end
end