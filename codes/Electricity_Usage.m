% In this project we will work with a dataset of electricity usage in the United States. 
% The dataset contains monthly usage across three sectors: residential, commercial, and industrial. 
% The values represent the total consumption in a given month in units of megawatt hours.
clc, clear, close all;

% First we make a table of the data coming from a .csv file.
data = readtable("electricityData.csv");

res = data{:,2}; % electricity usage for residential sector.
comm = data{:,3}; % electricity usage for commercial sector.

% Scatter plot.
scatter(res, comm);
% Adding labels and title to the scatter plot
xlabel('Residential Electricity Usage (MWh)');
ylabel('Commercial Electricity Usage (MWh)');
title('Scatter Plot of Residential vs Commercial Electricity Usage');

% Correlation coefficient matrix for res and comm data.
resCommCorr = corrcoef(res, comm) % corrcoef returns NaNs if one of the data points is missing.
resCommCorr = corrcoef(res, comm, "Rows", "complete") % Extra options ingore NaN values.

% Extracting the correleation coefficient.
coef = resCommCorr(1,2)

% Electricity usage data.
usage = data{:,2:5};

% Matrix of plots.
plotmatrix(usage);

% Correlation coefficient matrix for usage data.
usageCorr = corrcoef(usage)
usageCorr = corrcoef(usage, "Rows", "complete") % Extra options ingore NaN values.
usageCorr = corrcoef(usage, "Rows", "pairwise") % Extra options require that the rows be pairwise complete to include more data. 

%%
clc, clear, close all;
x = 1:8;
y = [7.20 12.00 17.60 18.1 23.50 30.20 32.40 38.00];
plot(x,y,"ob")

% Fit a first degree polynomial in terms of x to the vector y.
c = polyfit(x,y,1) % Vector of polynomial coefficients.

% The value of the fitted polynomial at each of the x values.
yFit = polyval(c,x)

hold on
plot(x,yFit,"r");
grid on
hold off

%%
clc, clear, close all;

% Convert a datetime vector to a numeric vector of elapsed times.
% That is because large values can lead to numerical innacuracies.

data = readtable("electricityData.csv");
dates = data.Date
res = data{:,2};
plot(dates,res,".-")

% To perform polynomial fitting, you must first convert the dates to elapsed times.
% The first step is to subtract all of the values contained in dates by the first value so that your numeric data will start from zero.
tDur = dates - dates(1)

% Currently, the units of the values contained in tDur are hours.
% Use the days function to return the number of days represented. Store the result in a variabe named t.
t = days(tDur)

% Fit a cubic polynomial to the residential usage data as a function of t. 
% Use centering and scaling to ensure accuracy.
[c,~,sc] = polyfit(t,res,3)

% Evaluate the fitted polynomial at the same t values.
yFit = polyval(c,t,[],sc)

% Polyfit doesn't ignore NaNs, so a trick needs to be implemented.
% Identify NaN values in the residential usage data and create a mask.
nanMask = isnan(res);
% Apply the mask to the residential usage data to exclude (~nanMask) NaN values.
resClean = res(~nanMask);
tClean = t(~nanMask);
% Fit a cubic polynomial to the cleaned residential usage data as a function of tClean.
[c,~,sc] = polyfit(tClean, resClean, 3)
% Evaluate the fitted polynomial at the initial t values.
yFit = polyval(c,t,[],sc)

hold on
grid on
plot(t,yFit)
hold off
