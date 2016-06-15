
%clear all
close all
clc



load prueba

group = test_labels1;
grouphat = pred;
scores = distances;
stats = confusionmatStats(group,grouphat);

perfcurve(group',scores',grouphat')

% group = true class labels
% grouphat = predicted class labels