function out = resulting_dist(data)
params = [];
params.distribution = 'gaussian';
params.D = 1;
params.memory = memory;
params.hazard = base_hazard;
params.prior = estimate_suffstat(std(data)*randn(1000,1),params);
out = run_DREX_model(data,params);
n = 100;
% Extract the 100x1 vectors from your structure
mu_vec  = out.prediction_params{n, 1}.mu;   % 100x1 vector of means
var_vec = out.prediction_params{n, 1}.cov;  % 100x1 vector of variances

% Extract weights from the 100th column of out.context_beliefs
weights = out.context_beliefs(1:n, n); % Extract 100x1 column vector

% Preallocate a cell array to store the predictive distributions
predictive_distr = cell(n, 1);

% Loop through each prediction and create a normal distribution object
for i = 1:n
    predictive_distr{i} = makedist('Normal', 'mu', mu_vec(i), 'sigma', sqrt(var_vec(i)));
end

% Compute weighted mean
mu_mixture = sum(weights .* mu_vec);

% Compute weighted variance (law of total variance)
var_mixture = sum(weights .* (var_vec + mu_vec.^2)) - mu_mixture^2;
sigma_mixture = sqrt(var_mixture);

% Create the final weighted mixture distribution
mixture_dist = makedist('Normal', 'mu', mu_mixture, 'sigma', sigma_mixture);

% Generate a sample from the mixture distribution
mixture_sample = random(mixture_dist, 1, 1);

% Display results
disp('Weighted Mixture Distribution Parameters:');
disp(['Mean: ', num2str(mu_mixture)]);
disp(['Variance: ', num2str(var_mixture)]);
disp(['Standard Deviation: ', num2str(sigma_mixture)]);

disp('Sample from the weighted mixture distribution:');
disp(mixture_sample);

% ----- PLOT THE RESULTING DISTRIBUTION -----
x = linspace(mu_mixture - 4*sigma_mixture, mu_mixture + 4*sigma_mixture, 1000); % Range for plotting
y = pdf(mixture_dist, x); % Compute PDF values

figure;
plot(x, y, 'b', 'LineWidth', 2);
hold on;
xlabel('x');
ylabel('Density');
title('Weighted Mixture Distribution PDF');
grid on;

% Plot individual predictive distributions (optional)
for i = 1:n
    y_i = pdf(predictive_distr{i}, x);
    plot(x, y_i * weights(i), 'r--', 'LineWidth', 0.5); % Scale by weight
end

legend('Mixture Distribution', 'Component Distributions (Weighted)');
hold off;