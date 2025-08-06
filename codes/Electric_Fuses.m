%==========================================================================
% Project: Data Analysis for Fuse Current Measurements
%
% This script loads a vector of current measurements for 25 fuses at 40 A
% and performs the following analyses:
%   1. Descriptive statistics: mean, variance, standard deviation
%   2. Visualization: histogram and boxplot
%   3. Confidence intervals for mean, variance, and standard deviation
%   4. Alternative computation of confidence intervals with normfit
%   5. Hypothesis test on the mean (ttest)
%   6. Hypothesis test on the variance (vartest)
%   7. Goodness-of-fit test for normality (chi2gof)
%
% All inline comments explain each step in English.
%==========================================================================

clc; clear, close all;

% Calculate descriptive statistics for the sample.
X = [40.9, 40.3, 39.8, 40.1, 39.0, 41.4, 39.8, 41.5, 40.0, 40.6, ...
     38.3, 39.0, 40.9, 39.1, 40.3, 39.3, 39.6, 38.4, 38.4, 40.7, ...
     39.7, 38.9, 38.9, 40.6, 39.6];

muHat    = mean(X);  % Sample mean.
sigmaHat = std(X);   % Sample standard deviation.
varHat   = var(X);   % Sample variance.

[muCI, sigmaCI, varCI] = Confidence_Interval_Calc(X)

%% Visualization.

% Create a normalized histogram of the data.
figure;
histogram(X, 'Normalization', 'pdf');  % Display PDF estimate.
xlabel('X');
grid on;

% Create a boxplot of the data.
figure;
boxplot(X);
ylabel('X');
grid on;

%% Confidence interval for the mean μ.

alpha = 0.05;                          % Significance level => 95% CI.
se    = sigmaHat / sqrt(length(X));   % Standard error of the mean.
pLo   = alpha/2;                       % Lower tail probability.
pUp   = 1 - alpha/2;                   % Upper tail probability.
tcrit = tinv([pLo, pUp], length(X)-1); % Critical t-values, df = n-1.

% Compute the confidence interval for the mean.
ci_mu = muHat + tcrit * se;
fprintf('95%% CI for mean μ: [%.2f, %.2f]\n', ci_mu);

%% Confidence interval for the variance σ^2.

% Critical chi-square values, df = n-1.
chi2crit = chi2inv([pLo, pUp], length(X)-1);

% Compute the confidence interval for the variance.
ci_var = [ (length(X)-1)*varHat/chi2crit(2), ...
           (length(X)-1)*varHat/chi2crit(1) ];
fprintf('95%% CI for variance σ^2: [%.2f, %.2f]\n', ci_var);

% Compute the confidence interval for the standard deviation.
ci_sigma = sqrt(ci_var);
fprintf('95%% CI for std dev σ: [%.2f, %.2f]\n', ci_sigma);

%% Alternative computation with normfit().

alpha = 0.05;  % Significance level
[muHat2, sigmaHat2, muCI2, sigmaCI2] = normfit(X, alpha);
% muCI2: CI for mean, sigmaCI2: CI for standard deviation.
varCI2 = sigmaCI2 .^ 2;  % CI for variance.

%% Use custom confidence_interval_calc() function.

[muCI3, sigmaCI3, varCI3] = Confidence_Interval_Calc(X);
% muCI3, sigmaCI3, varCI3 contain the three CIs from the user function.

%% Hypothesis test for the mean μ.

mu = mean(X);
h = ttest(X, mu);  % Test H0: mean = mu, H1: mean ≠ mu.
if h == 0
    disp('Null hypothesis accepted (mean = mu).');
else
    disp('Null hypothesis rejected (mean ≠ mu).');
end

% Retrieve detailed test output.
[h, p, ci, stats] = ttest(X, mu);
% stats.tstat: t-statistic, stats.df: degrees of freedom, stats.sd: sample std.

% Change significance level.
alpha = 0.01;
h = ttest(X, mu, 'Alpha', alpha);

%% Hypothesis test for the variance σ^2.

variance = var(X);
h = vartest(X, variance);  % Test H0: variance = variance, H1: ≠
if h == 0
    disp('Null hypothesis accepted (variance = specified).');
else
    disp('Null hypothesis rejected (variance ≠ specified).');
end

% Retrieve detailed test output for variance test.
[h, p, ci, stats] = vartest(X, variance);
% stats.chi2stat: chi-square statistic, stats.df: degrees of freedom.

% Change significance level.
alpha = 0.01;
h = vartest(X, variance, 'Alpha', alpha);

%% Goodness-of-fit test for normality.

[h, p, stats] = chi2gof(X);  % Test H0: data ~ Normal(mean, var).
if h == 0
    disp('Data follow a normal distribution.');
else
    disp('Data do not follow a normal distribution.');
end
fprintf('Chi-square statistic: %.2f\n', stats.chi2stat);
