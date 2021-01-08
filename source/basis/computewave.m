function [Scfun, Wavefun, Cwave, Dwave] = computewave(M,V,n);
% Compute scaling functions and HB
% from momemnt matrix
[U,D,G] = svd(M);

% Construct scaling functions
numofscalingfunctions = nnz(diag(D));
Cwave = G(:,1 : numofscalingfunctions);
Scfun = V * Cwave;

% Construct multilevel basis (wavelets)
if n > numofscalingfunctions
    numofwavelets  = n - numofscalingfunctions;
    Dwave = G(:,numofscalingfunctions + 1 : end);
    Wavefun = V * Dwave;
else
    Wavefun = [];
    Dwave = [];
end
