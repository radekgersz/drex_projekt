%% Wykres 1 - noise 0 hazard 0.95 - osoby medytuj¹ce 

data = readtable('signal_100_2.csv', 'ReadVariableNames', false);
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

sum(out.surprisal)
%% wykres 2 - noise = 1, hazard 0.05 - osoby niemedytujace

data = readtable('signal_100_2.csv', 'ReadVariableNames', false);
vector = table2array(data(1, :));

rng(10);
x = vector';

params = [];
params.distribution = 'gaussian';
params.hazard = 0.05;
params.obsnz = 1;
params.prior = estimate_suffstat(std(x)*randn(1000,1),params);
x = vector';
out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)

sum(out.surprisal)

%% wykres 3 - noise = 1, hazard 0.95

data = readtable('signal_100_2.csv', 'ReadVariableNames', false);
vector = table2array(data(1, :));

rng(10);
x = vector';

params = [];
params.distribution = 'gaussian';
params.hazard = 0.95;
params.obsnz = 1;
params.prior = estimate_suffstat(std(x)*randn(1000,1),params);
x = vector';
out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)


%% Wykres 4 - noise 0 hazard 0.05

data = readtable('signal_100_2.csv', 'ReadVariableNames', false);
vector = table2array(data(1, :));

rng(10);
x = vector';

params = [];
params.distribution = 'gaussian';
params.hazard = 0.05;
params.obsnz = 0;
params.prior = estimate_suffstat(std(x)*randn(1000,1),params);
x = vector';
out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)
sum(out.surprisal)
%%

