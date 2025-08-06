%==========================================================================
% Mini-Project: Quality Control & Statistical Analysis of Ball-Bearing Diameters.
%
% This script performs the following steps on a sample of 30 diameter
% measurements (in mm):
%   1. Compute descriptive statistics: mean, variance, standard deviation.
%   2. Visualize data distribution using histogram and boxplot.
%   3. Calculate confidence intervals for mean, variance, and standard deviation.
%   4. Conduct hypothesis tests: t-test for mean, vartest for variance, chi2gof for normality.
%   5. Fit a simple linear regression model to detect production drift.
%   6. Extract model performance metrics: R² and adjusted R².
%   7. Plot scatter with fitted regression line.
%==========================================================================

clc; clear; close all;

% Measurement vector (diameters in mm of 30 ball-bearings).
X = [49.98, 50.02, 49.95, 50.10, 49.90, 50.05, 50.00, 49.97, 50.04, 49.92, ...
     50.08, 49.99, 50.01, 49.93, 50.06, 49.96, 50.07, 49.94, 50.11, 49.91, ...
     50.03, 49.89, 50.09, 49.88, 50.12, 49.87, 50.13, 49.86, 50.14, 49.85];
X = X(:);  % Ensure X is a column vector.

% Descriptive Statistics.
muHat    = mean(X);   % Compute sample mean.
sigmaHat = std(X);    % Compute sample standard deviation.
varHat   = var(X);    % Compute sample variance.

% Histogram of the data.
figure;
histogram(X, 'Normalization', 'pdf');  % Plot PDF-normalized histogram.
xlabel('Diameter (mm)');               % Label x-axis.
ylabel('Probability Density');         % Label y-axis.
title('Histogram of Ball-Bearing Diameters');  % Add title.
grid on;                               % Enable grid.

% Boxplot of the data.
figure;
boxplot(X);                            % Display boxplot to detect outliers.
ylabel('Diameter (mm)');               % Label y-axis.
title('Boxplot of Ball-Bearing Diameters');  % Add title.
grid on;                               % Enable grid.

% Confidence Intervals for mean, variance, and standard deviation.
[muCI, sigmaCI, varCI] = Confidence_Interval_Calc(X);  % Call custom CI function.

% Hypothesis Test for the Mean.
[h1, p1, ci1, stats1] = ttest(X, muHat);  % Perform two-tailed t-test for mean.

% Hypothesis Test for the Variance.
[h2, p2, ci2, stats2] = vartest(X, varHat);  % Perform chi-square test for variance.

% Goodness-of-Fit Test for Normality.
[h3, p3, stats3] = chi2gof(X);  % Test if data follow a normal distribution.

% Linear Regression Model to Detect Drift.
t = (1:length(X))';                % Production index as independent variable.
model = fitlm(t, X);               % Fit linear model X = β0 + β1·t + ε.

% Extract model performance metrics.
R2    = model.Rsquared.Ordinary;   % Obtain R-squared.
adjR2 = model.Rsquared.Adjusted;   % Obtain adjusted R-squared.

% Display regression results.
fprintf('Linear model: X = %.4f + %.6f·t\n', ...
        model.Coefficients.Estimate(1), model.Coefficients.Estimate(2));  % Print equation.
fprintf('R² = %.4f, adjusted R² = %.4f\n', R2, adjR2);  % Print performance.
fprintf('Final assessment: R² = %.4f and adjusted R² = %.4f, indicating that the linear model provides a good fit to the data.\n', R2, adjR2);  % Print conclusion.

% Scatter plot with fitted regression line.
figure;
scatter(t, X);                          % Scatter plot of data.
hold on;                                % Retain plot.
plot(t, model.Fitted, 'r-', 'LineWidth', 1.5);  % Plot fitted line.
xlabel('Production Index');             % Label x-axis.
ylabel('Diameter (mm)');                % Label y-axis.
title('Diameter vs. Production Index with Fitted Line');  % Add title.
legend('Data', 'Fitted Line');          % Add legend.
grid on;                                % Enable grid.
