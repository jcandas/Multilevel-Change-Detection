function parameters = initKLSP;

% Close all figures
close all

% Initialize parameters for spherical harmonic expansion of Weiner process
parameters.KL.l = 10;
numofpoints = 10000; 

% Create Barycenter points from theta and phi
% rng default

% Irregular sampling of the sphere
[theta,phi] = GridSphere(numofpoints);
% Note that the GridSphere completes the necessary number of points
% to achieve an almost evenly spread on the sphere

theta = deg2rad(theta);
phi = pi + deg2rad(phi);

theta = pi/2 - theta(:);
phi = phi(:);
coord = [theta phi];

% Used for plotting
width = 400;
[TH PHI] = meshgrid([linspace(0,pi,width)],[linspace(0, 2 * pi,width)]);
coordplot = [TH(:) PHI(:)];


parameters.KL.plotwidth = width;
parameters.KL.n = size(coord,1);
parameters.KL.coord = coord;
parameters.KL.coordplot = coordplot;
parameters.KL.plotrealization = true; % Plot a spherical realization

% Plot realizations
tol = 1e-4;
%tol = 1e-5;
numlevel = 2; %Choose maximal level
parameters.ML.plot.tol = tol;
parameters.ML.plot.numlevel = numlevel;