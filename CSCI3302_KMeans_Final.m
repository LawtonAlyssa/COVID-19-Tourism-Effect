clc; clear all; close all;
%% State of Hawaii Data
rng('default');%for reproducability
load('covid_state_final.mat');
XState = covid_state_final(:,1:3);
idxState = processKmeans(XState);
%% Island of Oahu Data
rng('default');%for reproducability
load('covid_oahu_final.mat');
XOahu = covid_oahu_final(:,1:3);
idxOahu = processKmeans(XOahu);
%% Island of Hawaii Data
rng('default');%for reproducability
load('covid_hawaii_final.mat');
XHawaii = covid_hawaii_final(:,1:3);
idxHawaii = processKmeans(XHawaii);
%% Island of Maui Data
rng('default');%for reproducability
load('covid_maui_final.mat');
XMaui = covid_maui_final(:,1:3);
idxMaui = processKmeans(XMaui);
%% Island of Kauai Data
rng('default');%for reproducability
load('covid_kauai_final.mat');
XKauai = covid_kauai_final(:,1:3);
idxKauai = processKmeans(XKauai);
%% State Early Pandemic Period & Vaccine Period Data
rng('default');%for reproducability
load('covid_early_vaccine_final.mat');
XVacc = covid_early_vaccine_final(:,1:3);
idxVacc = processKmeans(XVacc);
%% Functions
% return function calls all functions to process data set and returns the
% cluster corresponding to each data point
function idx = processKmeans(X)
    plotData3d(X)
    [idx,C] = kmeansPlot(X);
    centroidTable(C)
end

% void function plots all data on a 3-Dimensional Plot
function plotData3d(X)
    figure;
    plot3(X(:,1),X(:,2),X(:,3),'b.','MarkerSize',7);
    title 'Effect of Tourism on COVID-19 Cases';
    xlabel 'Trans-Pacific Passenger Arrivals';
    ylabel 'COVID-19 Cases Travel Associated'; 
    zlabel 'Percentage of COVID-19 Cases Travel Associated';
end

% return function calculates and plots the silhouette values for clusters
% ranging from 2-30 along with returns 
function K = evalPlotClusters(X)
    E = evalclusters(X,'kmeans','Silhouette','klist',[2:30]);
    figure
    plot(E)
    K = E.OptimalK;
end

% return function processes kmeans clustering algorithm and plots all data
% organized in clusters along with centroids. Function also returns
% centroid values in an array
function [idx,C] = kmeansPlot(X)
    rng('default'); % For reproducibility
    K = evalPlotClusters(X);
    [idx,C] = kmeans(X,K); % partitions training data into 8 clusters by using kmeans

    figure
    scatter3(X(:,1),X(:,2),X(:,3),20,idx,'filled') % 3D-Scatter Plot
    hold on
    plot3(C(:,1),C(:,2),C(:,3),'ks', 'MarkerSize', 5, 'Linewidth',1)
    title 'K-Means Clusters - Effect of Tourism on COVID Cases'
    xlabel 'Trans-Pacific Passenger Arrivals';
    ylabel 'COVID-19 Cases Travel Associated'; 
    zlabel 'Percentage of COVID-19 Cases Travel Associated'; 
    legend('Clusters','Cluster Centroid')
end

% void function generates a table containing all centroid values from
% kmeans clustering algorithm
function centroidTable(C)
    T = array2table(C,'VariableNames',{'Arrivals','# of Travel COVID Cases','% of Travel Covid Cases'});
    T
end