function [Scfun, Wavefun, Cwave, Dwave] = leaflocalbasis(datapoints, coords, polymodel,degree)

% Create local Hierarchical Basis with vanishing moments
% with respect to the polynomial model

coords = coords(datapoints,:);
[n,m] = size(coords);

% Initial basis 
V = eye(n);

% Create local momement matrix
Q = PolynomialMonomials(degree, coords, polymodel, datapoints);
M = Q' * V;

% obtain HB basis
[Scfun, Wavefun, Cwave, Dwave] = computewave(M,V,n);
