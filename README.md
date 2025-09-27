# Data Analysis Projects

MATLAB implementations of practical data analysis tasks in manufacturing quality control, statistical inference, energy modeling, and vehicle performance analytics. The code combines classic statistics, visualizations, regression models, and curve fitting.

Developed as part of coursework in **Data Analysis** at the School of Electrical and Computer Engineering, Aristotle University of Thessaloniki.

---

## Subproject 1: Ball Bearing Quality Control

**Files:** `Ball_Bearing.m`, `Confidence_Interval_Calc.m`  
**Topic:** Statistical Analysis & Process Monitoring

This project analyzes a set of 30 ball-bearing diameter measurements through:

- Descriptive statistics (mean, std, variance)
- Data visualization (histogram, boxplot)
- Confidence intervals for mean, variance, std
- Hypothesis testing (t-test, vartest, chi² goodness-of-fit)
- Linear regression to detect potential drift in manufacturing
- Model evaluation via R² and adjusted R²

---

## Subproject 2: Electric Fuse Current Statistics

**File:** `Electric_Fuses.m`  
**Topic:** Inference & Goodness-of-Fit Testing

A vector of 25 current measurements is analyzed through:

- Descriptive statistics and confidence intervals
- Histogram and boxplot visualizations
- Comparison between manual & built-in MATLAB tools (`normfit`)
- Hypothesis testing on:
  - Mean (t-test)
  - Variance (chi² test)
  - Normality (chi² goodness-of-fit)

---

## Subproject 3: Electricity Usage Modeling

**File:** `Electricity_Usage.m`  
**Topic:** Correlation & Polynomial Regression on Energy Data

Analyzes U.S. electricity consumption across residential, commercial, and industrial sectors using real-world data:

- Scatter plots & plot matrix
- Correlation coefficients with NaN-handling
- Polynomial fitting:
  - Linear model to synthetic data
  - Cubic model for residential usage time series

---

## Subproject 4: Vehicle Dataset Exploration

**File:** `Vehicle_Data.m`  
**Topic:** Multivariate Vehicle Analysis – Weight, Power & Fuel Economy

Explores relationships between vehicle **weight**, **horsepower**, and **fuel economy** using:

- Scatter plot matrix and correlation matrix
- Linear regression:
  - Fuel economy vs. weight
  - Horsepower vs. weight
- Dual-axis plot to visualize both fitted models

---

## Author

**Βασίλειος Μπαρμπαγιάννος**  
Student at ECE AUTH – School of Electrical & Computer Engineering  
AEM: 10685

---
