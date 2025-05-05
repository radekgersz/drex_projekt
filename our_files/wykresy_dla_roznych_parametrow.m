%% test
rng(10);
x = [2*randn(50,1); 6*randn(50,1)];

params = [];
params.distribution = 'gaussian';
params.D = 1;
params.prior = estimate_suffstat(std(x)*randn(1000,1),params);
params.hazard = 0.00000001;
x = [2*randn(50,1); 6*randn(50,1)];
out = run_DREX_model(x,params);

%% hz plot
hz_sup = display_hz_plot(100, 0.01, x,2);

% Extract columns
x_values = hz_sup(:,1); % First column for x-axis
y_values = hz_sup(:,2); % Second column for y-axis

%plot data
figure;
plot(x_values, y_values);


%% observational noise plot


noise =  display_obs_noise_plot(100, 0.1, 5, x, inf, 0.01);

x_values = noise(:,1); % First column for x-axis
y_values = noise(:,2); % Second column for y-axis

%plot data
figure;
plot(x_values, y_values);

