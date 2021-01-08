% Example of change detection on spherical domain using the 
% multilevel nested functional space approach.



%% Methods
methods.initialization = @initKLSP;
methods.KLeigenspace = @KLWeinerSphere;
methods.KLmultilevel = @multilevelHB;
methods.MLtest = @testtransform;
methods.KLRealization = @KLSPrealization;
methods.MLtransform = @mltransform;
methods.KLMLplot = @plotKLSP;
methods.KLMLtest = @testKLSP;

% External toolboxes
methods.toolboxes.GridSphere = @GridSphere;

%% Initialize parameters
parameters = methods.initialization();

% Create Eigenvectors of Wiener process on a sphere
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
