function [outputcoeff, levelcoeff, dcoeffs, ccoeffs, nodeindex] = hbtrans(fdata, transformcell, ind, datacell, datalevel)

% Multilevel transform;
% Performs projection of the data fdata to the multilevel
% basis in transformcall

% Projection
numofnodes = size(transformcell, 1);
coeff = [];
levelcoeff = [];
dcoeffs = cell(numofnodes,1);
ccoeffs = cell(1);
nodeindex = cell(numofnodes,1);

% Up to level 0 of HB coefficients

for n = numofnodes : -1 : 1 
    if isempty(transformcell{n,2}) == 0       
        ixds = datacell{ind(n)};
        W = transformcell{n,2}; 
        localcoeff = fdata(ixds)' * W;
        coeff = [coeff localcoeff];
        levelcoeff = [levelcoeff; datalevel(ind(n)) * ones(size(W,2),1) ];
        dcoeffs{n} = localcoeff;
        nodeindex{n} = ixds;
    end
end

% Perform zero last level

if isempty(transformcell{1,1}) == 0
    V = transformcell{1,1};
    coeff = [coeff fdata' * V];
    ccoeffs = fdata' * V;
    levelcoeff = [levelcoeff; -ones(size(V,2),1) ];
    coeff = coeff';
end

nfdata = length(fdata);
outputcoeff = zeros(nfdata,1);
outputcoeff(1 : length(coeff)) = coeff;
