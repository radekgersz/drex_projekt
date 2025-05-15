%%
% Define total length of the matrix
N = 100;  
num_values = 6;  % Number of random values to place

% Initialize the matrix with zeros
A = zeros(1, N);

% Define the minimum and maximum gap sizes
min_gap = 13;
max_gap = 20;

% Start placing the first number at a random position within the first max_gap range
positions = zeros(1, num_values);
positions(1) = randi([1, max_gap]);

% Generate the remaining positions ensuring the gap constraint
for i = 2:num_values
    min_pos = positions(i-1) + min_gap;  % Ensure at least min_gap distance
    max_pos = min(positions(i-1) + max_gap, N - (num_values - i) * min_gap); % Ensure enough space left
    if min_pos > max_pos
        error('Not enough space to place all values with required gaps.');
    end
    positions(i) = randi([min_pos, max_pos]); % Random position within valid range
end

% Generate random values from a normal distribution (mean=0, std=1)
random_values = randn(1, num_values);  % Change this if a different distribution is needed

% Assign the random values to the generated positions
A(positions) = random_values;

A = A';
rng(10);

x = [2*randn(50,1); 6*randn(50,1)];

params = [];
params.distribution = 'gaussian';
params.D = 1;
params.prior = estimate_suffstat(std(A)*randn(1000,1),params);

out = run_DREX_model(A,params);

figure(1); clf;
display_DREX_output(out,A)
%% running the model with data that was generated in python
data = readtable('lista.csv', 'ReadVariableNames', false);
vector = table2array(data(1, :));

rng(10);
x = vector';

params = [];
params.distribution = 'gaussian';
params.D = 1;
params.hazard = 0.2;
params.prior = estimate_suffstat(std(x)*randn(1000,1),params);
x = vector';
out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)

%% data generated in python with values replaced 
data = readtable('lista_2.csv', 'ReadVariableNames', false);
vector = table2array(data(1, :));

rng(10);
x = vector';


params = [];
params.distribution = 'gaussian';
params.D = 1;
params.hazard = 0.2;
params.prior = estimate_suffstat(std(x)*randn(1000,1),params);
params.memory = 40;
x = vector';
out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)

%% computing the weighted distributions
[mixture_dist, mixture_sample] = compute_weighted_mixture(out, 90);


%% plotting suprisal to hazard rate

 hz_sup = display_hz_plot(100,0.01,x,2);


% Extract columns
x_values = hz_sup(:,1); % First column for x-axis
y_values = hz_sup(:,2); % Second column for y-axis

% Plot the data
figure;
plot(x_values, y_values);

% Customize the plot
xlabel('Column 1 (X-axis)');
ylabel('Column 2 (Y-axis)');
title('Scatter Plot of hz\sup Data');
legend;
grid on;

%% plotting suprisal to working memory

 hz_sup = display_working_memory_plot(100,0.01,x);


% Extract columns
x_values = hz_sup(:,1); % First column for x-axis
y_values = hz_sup(:,2); % Second column for y-axis

% Plot the data
figure;
plot(x_values, y_values);

% Customize the plot
xlabel('Column 1 (X-axis)');
ylabel('Column 2 (Y-axis)');
title('Scatter Plot of hz\sup Data');
legend;
grid on;
%%
data = readtable('lista_2.csv', 'ReadVariableNames', false);
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


%% 100 bodŸców - z cisz¹ 
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

%% 100 bodŸców bez ciszy


data = readtable('signal_100_nobaseline.csv', 'ReadVariableNames', false);
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


%% 200 bodŸców - cisza


data = readtable('signal_200.csv', 'ReadVariableNames', false);
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


%% hazard memory plot - wynik 

result = display_hazard_memory_plot(35,0.01,x,2)

hazards = result(:, :, 1);
memories = result(:, :, 2);
surprisals = result(:, :, 3);

figure;
surf(hazards, memories, surprisals);
xlabel('Hazard');
ylabel('Memory');
zlabel('Surprisal (std)');
title('Surprisal as a function of Hazard and Memory');
colorbar;
shading interp; % Smoothens the surfac


%% hazard noise plot

result = display_hazard_noise_plot(20,0.01,x,0)

hazards = result(:, :, 1);
noises = result(:, :, 2);
surprisals = result(:, :, 3);

figure;	
surf(hazards, noises, surprisals);
xlabel('Hazard');
ylabel('noise');
zlabel('Surprisal (std)');

title('Surprisal as a function of Hazard and noise');
colorbar;
shading interp; % Smoothens the surface


%% noise plot 

res = display_obs_noise_plot(25,0,50,x,inf,0.7);

%% memory plot

wyn = memory_plot(10,2,11,x,0.05)

noises = wyn(:,1);
surprisals = wyn(:,2);

figure;
plot(noises,surprisals)
