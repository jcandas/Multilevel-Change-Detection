function fdata = invhbtrans(dcoeffs, ccoeffs, transformcell, ind, datacell, datalevel, numofpoints)

% Inverse Multilevel transform;
% Reconstruct fdata from coeff and the multilevel
% basis in transformcall

% Reconstruction
numofnodes = size(transformcell, 1);
fdata = zeros(numofpoints, 1);


% Up to level 0 of HB coefficients

for n = numofnodes : -1 : 1 
    if isempty(transformcell{n,2}) == 0
        
        ixds = datacell{ind(n)};
        W = transformcell{n,2}; 
       
        fdata(ixds) = fdata(ixds) + W * dcoeffs{n}';
                
    end
end

% Perform zero last level
V = transformcell{1,1};
fdata = fdata +  V * ccoeffs';

