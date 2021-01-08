function parameters = KLSPrealization(parameters)


% Generate realization of 1D stochastic process
lambda = parameters.KL.lambda;
M = parameters.KL.M;
l = parameters.KL.l;
x = parameters.KL.coord;


% Realization of stochastic process with
% truncated KL expansion
cte = sqrt(3) * 2 * (rand(l,1) - 1/2);
output = 1 + M * (cte .* lambda);

parameters.KL.realization = output;
parameters.ML.input = output;

% Plot Figures
if parameters.KL.plotrealization == true;
    figure(1);
    plot(x,output);
    title('KL Realization');
end