function parameters = testKLML1D(parameters);

inputdata = parameters.ML.input;
coord = parameters.KL.coord;
numofpoints = length(parameters.KL.coord);

% Add Gaussian "bump" to the data
sbump = 0.5; % Mid location
sigma = sqrt(0.001);
maxbump = 0.05;
bump = maxbump * exp( - ((coord - sbump).^2)/ (sigma^2) );

% 
s1 = 150 / 500;
s2 = 350 / 500;

bump(1 : round(s1 * numofpoints)   ) = 0;
bump(round(s2 * numofpoints) : end ) = 0;

% Add the bump to the input data
parameters.ML.input = inputdata + bump;
parameters.KL.deviation = bump;
