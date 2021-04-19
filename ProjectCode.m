%% Stats Final Project 
clear,clc
% Read data table into matlab
T = readtable('harvesterData.csv');

T = T(:, 2:10); %taking out the subject ID coloumn
T.Loc = categorical(T.Loc);

%% Regression of Unsprung data

% Find equation and intercept for unsprung regression
regUnsprung = stepwiselm(T,'ResponseVar','Power_Unsprung','PredictorVars', {
    'Loc', 'Axrms', 'Ayrms', 'Azrms', 'Gxrms', 'Gyrms', 'Gzrms'}, 'CategoricalVars', {
    'Loc'},'PEnter',.01,'Upper','linear', 'Verbose',2)

% The variables x1, x2, x4, and x7 were the most infulencial in our linear
% regression equation. 
% R^2 = .818

%% Residuals for Unsprung Resgression
subplot(3,1,1)
plotResiduals(regUnsprung)
subplot(3,1,2)
plotResiduals(regUnsprung,'probability')
subplot(3,1,3)
plotResiduals(regUnsprung,'fitted')

%% Regression of Sprung data

% Find equation and intercept for unsprung regression
regSprung = stepwiselm(T,'ResponseVar','Power_Sprung','PredictorVars', {
    'Loc', 'Axrms', 'Ayrms', 'Azrms', 'Gxrms', 'Gyrms', 'Gzrms'}, 'CategoricalVars', {
    'Loc'},'PEnter',.01,'Upper','linear', 'Verbose',2)


% The x7 variable was the most influencial in our regression.
% R^2 = .34
% Location is important because it effects our accuracy in prediction.

%% Residuals for Sprung Regression
subplot(3,1,1)
plotResiduals(regSprung)
subplot(3,1,2)
plotResiduals(regSprung,'probability')
subplot(3,1,3)
plotResiduals(regSprung,'fitted')

%% First Order interactions for Unsprung

regUnsprungInt = stepwiselm(T,'ResponseVar','Power_Unsprung','PredictorVars', {
    'Loc', 'Axrms', 'Ayrms', 'Azrms', 'Gxrms', 'Gyrms', 'Gzrms'}, 'CategoricalVars', {
    'Loc'},'PEnter',.01,'Upper','interactions', 'Verbose',2)

regUnsprungQuad = stepwiselm(T,'ResponseVar','Power_Unsprung','PredictorVars', {
    'Loc', 'Axrms', 'Ayrms', 'Azrms', 'Gxrms', 'Gyrms', 'Gzrms'}, 'CategoricalVars', {
    'Loc'},'PEnter',.01,'Upper','purequadratic', 'Verbose',2)


%% First Order interactions for Sprung

regSprungInt = stepwiselm(T,'ResponseVar','Power_Sprung','PredictorVars', {
    'Loc', 'Axrms', 'Ayrms', 'Azrms', 'Gxrms', 'Gyrms', 'Gzrms'}, 'CategoricalVars', {
    'Loc'},'PEnter',.01,'Upper','interactions', 'Verbose',2)

regSprung = stepwiselm(T,'ResponseVar','Power_Sprung','PredictorVars', {
    'Loc', 'Axrms', 'Ayrms', 'Azrms', 'Gxrms', 'Gyrms', 'Gzrms'}, 'CategoricalVars', {
    'Loc'},'PEnter',.01,'Upper','purequadratic', 'Verbose',2)

