%% Add path to D-REX model code directory
% addpath('C:\Users\radek\OneDrive\Pulpit\LGPB pliki\Drex matlab\DREX-model-master');

%% Simple example of Gaussian sequence with one change
rng(10);

x = [2*randn(50,1); 6*randn(50,1)];

params = [];
params.distribution = 'gaussian';
params.D = 1;
params.prior = estimate_suffstat(std(x)*randn(1000,1),params);
params.hazard = 0.00000001;
x = [2*randn(50,1); 6*randn(50,1)];
out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x);

%% kopia 
rng(10);
x = [zeros(20,1);ones(20,1); zeros(20,1)];

params = [];
params.distribution = 'gaussian';
params.D = 1;
params.hazard = 0.2;
params.prior = estimate_suffstat(std(x)*randn(1000,1),params);
x = [zeros(20,1);ones(20,1);zeros(20,1)];
out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)
%% przerwy losowe
% Define total length of the matrix
N = 100;
num_tens = 7;

% Initialize the matrix with zeros
A = zeros(1, N);

% Define the minimum and maximum gap sizes
min_gap = 10;
max_gap = 20;

% Generate positions for the 10s ensuring gaps between min_gap and max_gap
positions = zeros(1, num_tens);
positions(1) = randi([1, max_gap]); % First 10 can be placed anywhere in the first max_gap

for i = 2:num_tens
    min_pos = positions(i-1) + min_gap;  % Ensure minimum gap
    max_pos = min(positions(i-1) + max_gap, N - (num_tens - i) * min_gap); % Ensure enough space left
    if min_pos > max_pos
        error('Not enough space to place all 10s with required gaps.');
    end
    positions(i) = randi([min_pos, max_pos]);
end

% Assign 10s to the generated positions
A(positions) = 10;

% Display the matrix

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


%% Same example w/ finite maxhyp
rng(10);
x = [2*randn(50,1); 6*randn(50,1)];

params = [];
params.distribution = 'gaussian';
params.D = 5;
params.prior = estimate_suffstat(std(x)*randn(1000,1),params);
%params.maxhyp = 30; % limits number of context hypotheses to 30, pruning by beliefs

x = [2*randn(50,1); 6*randn(50,1)];
out = run_DREX_model(x,params);

figure(2); clf;
display_DREX_output(out,x)

%% Gaussian mixture example with single wide component in prior

x = [-5+randn(1,50), 5+randn(1,50)]';
x = x(randperm(length(x)));
x = [rand(100,1)*range(x) + min(x); x];


params = [];
params.distribution = 'gmm';
params.max_ncomp = 10;
params.beta = 0.001;
params.D = 1;
params.prior = estimate_suffstat(randn(1000,1),params);
params.maxhyp = inf;
params.memory = inf;

out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)


%% Gaussian mixture example with spread out multi-component prior

x = [-5+randn(1,50), 5+randn(1,50)]';
x = x(randperm(length(x)));
x = [rand(100,1)*range(x) + min(x); x];


params = [];
params.distribution = 'gmm';
params.max_ncomp = 10;
params.beta = 0.001;
params.D = 1;
params.prior = estimate_suffstat(randn(1000,1),params);
params.prior.mu = {[-8:2:8 nan]};
params.prior.sigma = {[0.1*ones(1,9) nan]};
params.prior.n = {[ones(1,9) nan]};
params.prior.pi = {[1/9*ones(1,9) 0]};
params.prior.sp = {[ones(1,9) 0]};
params.prior.k = {9};


params.maxhyp = inf;
params.memory = inf;

out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)


%% Simple example w/ prior from several different sequences
exposure = cell(3,1);
exposure{1} = 2*randn(50,1);
exposure{2} = 6*randn(20,1);
exposure{3} = 0.5*randn(80,1);

x = [2*randn(50,1); 6*randn(50,1)];

params = [];
params.D = 1;
params.prior = estimate_suffstat(exposure,params); % priors calculated from exposure set

out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)


%% Example with temporal dependence D = 2 
x = zeros(100,1); % input: Gaussian random walk
for t = 2:100
    if t < 50
        s = .2;
    else
        s = -.2;
    end
    x(t) = x(t-1)+2*(randn(1)+s);
end

params = [];
params.D = 2;
params.memory = inf;
params.prior = estimate_suffstat(x,params);

out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)


%% Example with temporal dependence D >> 1 
exposure = 5*randn(100,1);
x = 5*repmat(randn(5,1),15,1)+randn(75,1); % noisy cycle

params = [];
params.D = 6;
params.memory = inf;
params.prior = estimate_suffstat(exposure,params);

out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)

%% Example with finite memory
x = [2*randn(50,1); 6*randn(50,1)];

params = [];
params.D = 1;
params.memory = 30;
params.prior = estimate_suffstat(permute(x,[1,3,2]),params);

out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)


%% Example with observation noise
x = [2*randn(50,1); 6*randn(50,1)];

params = [];
params.D = 1;
params.memory = inf;
params.obsnz = 3;
params.prior = estimate_suffstat(permute(x,[1,3,2]),params);

out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)


%% Example with missing/silent observations
x = [2*randn(50,1); 6*randn(50,1)];
x([30:35, 70:80]) = nan;

params = [];
params.D = 1;
params.prior = estimate_suffstat(permute(x,[1,3,2]),params);

out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)


%% Example with multiple features
x1 = [2*randn(70,1); 6*randn(30,1)];
x2 = [6*randn(50,1); 2*randn(50,1)];
x3 = [2*randn(30,1); 8+2*randn(70,1)];
x = [x1, x2, x3];

params = [];
params.D = 1;
params.prior = estimate_suffstat(permute(x,[1,3,2]),params);

out = run_DREX_model(x,params);

figure(1); clf;
display_DREX_output(out,x)


