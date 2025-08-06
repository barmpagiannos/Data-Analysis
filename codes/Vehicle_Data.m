% Analyze vehicle data.
clc, clear, close all;

% Table containing the weight, horsepower, and fuel economy in L/100km.
data = readtable("vehicleData.csv");

% Extract columns for analysis.
numData = [data.wt, data.hp, data.econ]

% Matrix of scatter plots.
plotmatrix(numData)

% Correlation coefficients matrix.
cc = corrcoef(numData)

% Fit a first-degree polynomial of fuel economy as a function of weight.
econFit = polyfit(data.wt, data.econ, 1)
% Evaluate the fitted model at the weights in the data.
econEval = polyval(econFit, data.wt)

% Fitting a line to horsepower as a function of weight.
hpFit = polyfit(data.wt, data.hp, 1)
% Evaluate the fitted model at the weights in the data.
hpEval = polyval(hpFit, data.wt)

scatter(data.wt, data.econ)
hold on
scatter(data.wt, data.hp)
yyaxis left
plot(data.wt, econEval, "b")
yyaxis right
plot(data.wt, hpEval, "r")
grid on
