% Function that computes the three confidence intervals for a data vector.

function [muCI, sigmaCI, varCI] = Confidence_Interval_Calc(x_array)

X = x_array;

% Compute confidence interval for the mean μ.
alpha = 0.05; % Significance level => 95% confidence interval.
se = std(X)/sqrt(length(X)); % Standard error of the estimator.
pLo = alpha/2; % Lower confidence bound.
pUp = 1 - alpha/2; % Upper confidence bound.
tcrit = tinv([pLo, pUp], length(X) - 1); % Critical t-value.
                                         % length(X) - 1: degrees of freedom.
% The confidence interval is:
ci_mu = mean(X) + tcrit*se;
muCI = ci_mu; % Return.

% Compute confidence interval for the variance σ^2.
chi2crit = chi2inv([pLo, pUp], length(X) - 1); % Critical chi^2-value.
                                               % length(X) - 1: degrees of freedom.
% The confidence interval is:
ci_var = [(length(X) - 1)*var(X)/chi2crit(2), (length(X) - 1)*var(X)/chi2crit(1)];
varCI = ci_var; % Return.

% The confidence interval for the standard deviation is:
ci_sigma = sqrt(ci_var);
sigmaCI = ci_sigma; % Return.

end
