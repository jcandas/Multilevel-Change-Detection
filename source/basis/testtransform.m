function parameters = testtransform(parameters,methods)



multileveltree = parameters.ML.multilevetree;
ind = parameters.ML.ind;
datacell = parameters.ML.datacell;
datalevel = parameters.ML.datalevel;

% Input eigenspace
polymodel.M = parameters.KL.M;

% Number of columns in the design matrix
params.indexsetsize = size(parameters.KL.M,2);
coord = parameters.KL.coord;
%degree = []; %Dummy variable, not used.


%% Run transform with random data
fprintf('\n');
fprintf('Test transform ---------------------------------\n');

% Create realization
parameters = methods.KLRealization(parameters);
Q = parameters.KL.realization;
numofpoints = size(coord,1);


%% Metrics
numvecs = size(Q,2);
maxerror = inf;
maxwaverror = inf;

tic;
for n = 1 : numvecs
    [coeff, levelcoeff, dcoeffs, ccoeffs] = hbtrans(Q(:,n), multileveltree, ind, datacell, datalevel);
    Qv = invhbtrans(dcoeffs, ccoeffs, multileveltree, ind, datacell, datalevel, numofpoints);
    polyerror(n) = norm(Q(:,n) - Qv, 2) / norm(Q(:,n));
    wavecoeffnorm(n) = norm(coeff(1 : end - params.indexsetsize),'inf')/norm(Q(:,n));
end
t = toc;

%%
fprintf('\n');
fprintf('Results: Num of tests = %d, Max Relative Error = %e \n', numvecs, max(polyerror));
fprintf('         Relative HBcoefficientsnorm =  %e \n', max(wavecoeffnorm));
fprintf('Total timing = %d seconds \n',t);
tic;
[coeff, levelcoeff, dcoeffs, ccoeffs] = hbtrans(Q(:,n), multileveltree, ind, datacell, datalevel);
t = toc;
fprintf('One Hierarchical Basis transform time = %d seconds \n',t);

% Test format change from vector of coefficients to struct
totalerror = 0;
[a b] = hbvectortocoeffs(coeff, multileveltree, ind, datacell, datalevel, numofpoints);
for i = 1 : length(dcoeffs)
   totalerror = totalerror + (norm(a{i} -  dcoeffs{i}));
end
totalerror = totalerror + (norm(b -  ccoeffs));
fprintf('Total error = %e \n', totalerror);