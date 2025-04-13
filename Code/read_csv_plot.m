% Define the file paths (adjust as necessary)
afterFile = "C:\Users\Eric\Desktop\PHYS 128\128AL_Mossbauer\Step 10 Hours Measurement\final.csv";
beforeFile = "C:\Users\Eric\Desktop\PHYS 128\128AL_Mossbauer\Step 8-9\60s\before_60s.csv";

% Load the channel and counts data from each CSV file.
[channels_after, counts_after] = loadChannelCounts(afterFile);
%[channels_before, counts_before] = loadChannelCounts(beforeFile);

% Create a new figure for the comparison plot
figure;

% Plot the "after" data with one marker style.
plot(channels_after, counts_after, 'o-', 'DisplayName', 'Final');
hold on;

% Plot the "before" data with a different marker style.
%plot(channels_before, counts_before, 'x-', 'DisplayName', 'Before 60s');

% Label the axes and add a title
xlabel('Channel #');
ylabel('Counts');
title('Comparison of Counts Before vs. After 60s');

% Add a legend and grid for clarity
legend('show');
grid on;
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: loadChannelCounts
%
% This function loads the channel and count data from a CSV file. It
% skips the first 23 rows and assumes that the remaining data are in three
% columns. The first column is assumed to be the channel #, and the third 
% column is the counts.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [channels, counts] = loadChannelCounts(fileName)
    % Read the numeric data from the CSV file, skipping the first 23 rows.
    data = readmatrix(fileName, 'NumHeaderLines', 23);
    
    % Extract the channel numbers (first column) and the counts (third column)
    channels = data(:, 1);
    counts = data(:, 3);
end
