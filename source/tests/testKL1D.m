% Example of change detection of 1D problem using the multilevel nested functional
% space approach.

%% Methods
methods.initialization = @initKL1D;
methods.KLeigenspace = @KL1D;
methods.KLmultilevel = @multilevelHB;
methods.MLtest = @testtransform;
methods.KLRealization = @KL1Drealization;
methods.MLtransform = @mltransform;
methods.KLMLplot = @plotKL1D;
methods.KLMLtest = @testKLML1D;

%% Initialize parameters
parameters = methods.initialization();

% Create Eigenvectors of Weiner process on a sphere
% spherical harmonics
parameters = methods.KLeigenspace(parameters);

% Create Multilevel Basis
parameters = methods.KLmultilevel(parameters,methods);

% Transfrom input to ML
parameters = methods.MLtransform(parameters);

% Create test input
parameters = methods.KLMLtest(parameters);

% Transfrom input with change to ML
parameters = methods.MLtransform(parameters);

% Plot transform
parameters = methods.KLMLplot(parameters);