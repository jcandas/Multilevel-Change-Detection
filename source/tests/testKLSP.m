function parameters = testKLSP(parameters);

% Spherical Fraction Brownian Motion
% Add deformation to the data

inputdata = parameters.ML.input;
coord = parameters.KL.coord;


% Add Gaussian "bump" to the data
sbump = pi/2;
sigma = 0.1;
maxbump = 0.5;

theta = coord(:,1);
phi =   coord(:,2);

bump = maxbump * exp( - ( (theta - pi/2).^2 ...
    + (phi - pi/2).^2 ) /sigma^2 );

% Add the bump to the input data
parameters.ML.input = inputdata + bump;
parameters.KL.deviation = bump;

% Plot the bump
figure(2);

[x,y,z] = sph2cart(phi, pi/2 - theta, 1 + bump);    
plot3(x,y,z,'b.');
hold on

[x,y,z] = sph2cart(phi, pi/2 - theta, ones(size(bump)));    
plot3(x,y,z,'b.');

axis equal
axis off

% Create bump for surface here
coordplot = parameters.KL.coordplot;

theta = coordplot(:,1);
phi =   coordplot(:,2);

bump = maxbump * exp( - ( (theta - pi/2).^2 ...
    + (phi - pi/2).^2 ) /sigma^2 );

% Add the bump to the input data
parameters.KL.plotdeviation = bump;

