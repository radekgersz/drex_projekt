%% Generate x values
x = [zeros(20,1);20;zeros(29,1);20; zeros(49,1)];

% Call display_hz_plot function (assuming it returns a 10x2 matrix)
hz_sup = display_hz_plot(100, 0.01, x,2);

% Extract columns
x_values = hz_sup(:,1); % First column for x-axis
y_values = hz_sup(:,2); % Second column for y-axis

% Plot the data
figure;
plot(x_values, y_values);

% Customize the plot
xlabel('Column 1 (X-axis)');
ylabel('Column 2 (Y-axis)');
title('Scatter Plot of hz_\sup Data');
legend;
grid on;
%% Generate x values
% Define parameters
n_samples = 100;
hazard_param = 0.01;  % Can change for different runs
x_values = [zeros(20,1); 20; zeros(29,1); 20; zeros(49,1)];

% Call the function
hz_mem_sup = display_hazard_memory_plot(n_samples, hazard_param, x_values, 2);

% Extract results
hazard_values = squeeze(hz_mem_sup(:,:,1));  % Hazard rates
memory_values = squeeze(hz_mem_sup(:,:,2));  % Memory values
surprisal_values = squeeze(hz_mem_sup(:,:,3)); % Surprisal std deviation

% Save the results to a file
filename = sprintf('hazard_memory_results_%.3f.mat', hazard_param);
save(filename, 'hz_mem_sup', 'hazard_values', 'memory_values', 'surprisal_values');

% Optional: Save as CSV (if needed)
csv_filename = sprintf('hazard_memory_results_%.3f.csv', hazard_param);
data_table = array2table([hazard_values(:), memory_values(:), surprisal_values(:)], ...
                         'VariableNames', {'Hazard', 'Memory', 'Surprisal'});
writetable(data_table, csv_filename);

% Create a 3D surface plot
figure;
surf(hazard_values, memory_values, surprisal_values, 'EdgeColor', 'none');

% Customize the plot
xlabel('Hazard Rate');
ylabel('Memory');
zlabel('Surprisal (std dev)');
title(sprintf('3D Surface Plot (Hazard Param = %.3f)', hazard_param));
colorbar;
grid on;
rotate3d on;

% Set the default view angle (optional)
view(135, 30);