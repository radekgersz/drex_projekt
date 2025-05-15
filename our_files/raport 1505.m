%% wykres oryginalny
data = readtable('signal_100.csv', 'ReadVariableNames', false);
vector = table2array(data(1, :));

rng(10);
x = vector';


params = [];
params.distribution = 'gaussian';
params.D = 1;
params.hazard = 0.05;
params.prior = estimate_suffstat(std(x)*randn(1000,1),params);
x = vector';
out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)


%% Wykres 1 - noise 0 hazard 0.95 - osoby medytuj¹ce 

data = readtable('signal_100.csv', 'ReadVariableNames', false);
vector = table2array(data(1, :));

rng(10);
x = vector';

params = [];
params.distribution = 'gaussian';
params.hazard = 0.95;
params.obsnz = 0;
params.prior = estimate_suffstat(std(x)*randn(1000,1),params);
x = vector';
out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)


%% wykres 2 - noise = 20, hazard 0.05 - osoby niemedytujace

data = readtable('signal_100.csv', 'ReadVariableNames', false);
vector = table2array(data(1, :));

rng(10);
x = vector';

params = [];
params.distribution = 'gaussian';
params.hazard = 0.05;
params.obsnz = 20;
params.prior = estimate_suffstat(std(x)*randn(1000,1),params);
x = vector';
out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)


%% wykres 3 - noise = 20, hazard 0.95

data = readtable('signal_100.csv', 'ReadVariableNames', false);
vector = table2array(data(1, :));

rng(10);
x = vector';

params = [];
params.distribution = 'gaussian';
params.hazard = 0.95;
params.obsnz = 20;
params.prior = estimate_suffstat(std(x)*randn(1000,1),params);
x = vector';
out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)



%% wykresy dla signal_100.csv 

params = [];
params.distribution = 'gaussian';
params.hazard = 0.95;
params.obsnz = 20;
params.prior = estimate_suffstat(std(x)*randn(1000,1),params);
data = readtable('signal_100.csv', 'ReadVariableNames', false);
vector = table2array(data(1, :));

rng(10);
x = vector';

res = display_obs_noise_plot(25,0,50,x,inf,0.7);

noises = res(:,1);
surprisals = res(:,2);

figure;
plot(noises,surprisals)


%% wykres dla observational noise i hazard rate dla danych z signal_100.csv
n_samples = 50;
hazard_lower_bound = 0;
hazard_upper_bound = 1;
noise_lower_bound = 0;
noise_upper_bound = 1.2;
result = display_hazard_noise_plot(n_samples, x, hazard_lower_bound, hazard_upper_bound, noise_lower_bound, noise_upper_bound)


