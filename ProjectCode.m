%% Stats Final Project 
clear,clc
% Read data table into matlab
T = readtable('harvesterData.csv');

% Create new tables separating our x and y values. Also change the xTable
% to an array for later application
xTable = T(:,2:8);
xTable.Loc = double(categorical(xTable.Loc));
yUnsprung = T(:,9);
ySprung = T(:,10);
xArray = table2array(xTable);


%% Regression of Unsprung data
% Turn unsprung y table into an array
yArrayUnsprung = table2array(yUnsprung);

% Find equation and intercept for unsprung regression
regUnsprung = stepwiselm(xArray,yArrayUnsprung,'PEnter',.01,'Upper','linear', 'Verbose',2)

% The variables x1, x2, x4, and x7 were the most infulencial in our linear
% regression equation. 
% R^2 = .818
subplot(3,1,1)
plotResiduals(regUnsprung)
subplot(3,1,2)
plotResiduals(regUnsprung,'probability')
subplot(3,1,3)
plotResiduals(regUnsprung,'fitted')

%% Regression of Sprung data
% Turn sprung y table into an array
yArraySprung = table2array(ySprung);

% Find equation and intercept for unsprung regression
regSprung = stepwiselm(xArray,yArraySprung,'PEnter', .01, 'Upper', 'linear', 'Verbose',2)

% The x7 variable was the most influencial in our regression.
% R^2 = .34
% Location is important because it effects our accuracy in prediction.

%% Residuals
subplot(3,1,1)
plotResiduals(regSprung)
subplot(3,1,2)
plotResiduals(regSprung,'probability')
subplot(3,1,3)
plotResiduals(regSprung,'fitted')

%% First Order interactions for Unsprung
yArrayUnsprung = table2array(yUnsprung);

regUnsprung = stepwiselm(xArray,yArrayUnsprung,'PEnter',.01,'Upper','interactions', 'Verbose',2)

regUnsprung2 = stepwiselm(xArray,yArrayUnsprung,'PEnter',.01,'Upper','purequadratic', 'Verbose',2)


%% First Order interactions for Sprung

yArraySprung = table2array(ySprung);

regSprung = stepwiselm(xArray,yArraySprung,'PEnter',.01,'Upper','interactions', 'Verbose',2)

regSprung2 = stepwiselm(xArray,yArraySprung,'PEnter',.01,'Upper','purequadratic', 'Verbose',2)

