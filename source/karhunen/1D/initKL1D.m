function parameters = initKL1D;

% Initialize 1D KL problem

% Close all figures
close all

% Define 1D domain
numofpoints = 500;
d = 1;
coord = linspace(0,d,numofpoints)';

% Number of eigenfunctions
parameters.KL.l = 10;

% Parameters of covariance function
Lc = 0.01;
Lp = max(d,2 * Lc);
%Lp = 1/4;
%L = 1/4;
L  = Lc / Lp;

% Output parameters
parameters.KL.Lc = Lc;
parameters.KL.Lp = Lp;
parameters.KL.L = Lc / Lp;

parameters.KL.n = size(coord,1);
parameters.KL.coord = coord;

% Plotting parameters
numlevel = 2; %Choose maximal level
parameters.KL.plotrealization = false; % Plot a relization
parameters.ML.plot.level = numlevel;