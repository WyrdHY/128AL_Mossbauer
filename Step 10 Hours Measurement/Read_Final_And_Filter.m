% Define file path (adjust as needed)
afterFile = "C:\Users\Eric\Desktop\PHYS 128\128AL_Mossbauer\Step 10 Hours Measurement\final.csv";

% Load the channel and counts data from the CSV file.
[channels_after, counts_after] = loadChannelCounts(afterFile);

% Apply a simple Kalman filter to smooth the counts data
[filteredCounts] = applyKalmanFilter(counts_after);

% Create a new figure for the comparison plot
figure;
plot(channels_after, counts_after, 'o-', 'DisplayName', 'Raw Data');
hold on;
plot(channels_after, filteredCounts, '-', 'DisplayName', 'Kalman Filtered','LineWidth',2);
xlabel('Channel #');
ylabel('Counts');
title('Comparison of Raw and Kalman Filtered Data');
legend('show');
grid on;
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: loadChannelCounts
%
% This function loads the channel and count data from a CSV file. It
% skips the first 23 rows and assumes that the remaining data are in three
% columns. The first column is the channel number, and the third column is the counts.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [channels, counts] = loadChannelCounts(fileName)
    % Read the numeric data from the CSV file, skipping the first 23 rows.
    data = readmatrix(fileName, 'NumHeaderLines', 23);
    
    % Extract the channel numbers (first column) and the counts (third column)
    channels = data(:, 1);
    counts = data(:, 3);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: applyKalmanFilter
%
% This function applies a simple one-dimensional Kalman filter to the 
% input data vector "counts". The system is assumed to be static with
% the measurement model z = x + noise. The filter parameters Q (process
% noise variance) and R (measurement noise variance) can be tuned.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function filteredData = applyKalmanFilter(measurements)
    % Number of measurements
    n = length(measurements);
    
    % Allocate memory for filtered estimates
    filteredData = zeros(n,1);
    
    % Kalman filter initialization
    % We initialize the state estimate with the first measurement.
    xhat = measurements(1);
    % Initial estimate covariance, can be tuned
    P = 1;
    
    % Tunable parameters: Process noise Q and measurement noise R.
    Q = 0.5;  % Process noise variance (assume very small changes)
    R = 12;     % Measurement noise variance (depends on your sensor noise)
    
    % Save the initial estimate
    filteredData(1) = xhat;
    
    % Kalman filter loop for each subsequent measurement.
    for k = 2:n
        % Prediction step:
        xhatminus = xhat;  % For a static model, prediction is previous state
        Pminus = P + Q;    % Increase in uncertainty
        
        % Kalman gain calculation:
        K = Pminus / (Pminus + R);
        
        % Update step with measurement measurements(k)
        xhat = xhatminus + K * (measurements(k) - xhatminus);
        P = (1 - K) * Pminus;
        
        % Store the filtered estimate
        filteredData(k) = xhat;
    end
end
