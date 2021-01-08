% function [Scfun, Wavefun, Cwave, Dwave] = localbasis(Vleft, Vright, idxs, coords, polymodel, degree);

function [Scfun, Wavefun, Cwave, Dwave] = localbasis(Vleft, left_idxs, Vright, right_idxs, idxs, coords, polymodel, degree);

% Create local Hierarchical Basis with vanishing moments
% with respect to the polynomial model. Use vectors from
% previous level on the tree

coords = coords(idxs,:);
[n,m] = size(coords);

% Initial basis 
 V = [[Vleft zeros(size(Vleft,1), size(Vright,2))];
    [zeros(size(Vright,1), size(Vleft,2)), Vright]
   ];

% sort V
[~, key] = sort([left_idxs  right_idxs]);
V = V(key,:);

% Create local momement matrix
Q = PolynomialMonomials(degree, coords, polymodel,idxs);
M = Q' * V;

% obtain HB basis
[Scfun, Wavefun, Cwave, Dwave] = computewave(M,V,n);
