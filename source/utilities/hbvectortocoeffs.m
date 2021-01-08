function [dcoeffs, ccoeffs] = hbvectortocoeffs(coeffsvector, multileveltree, ind, datacell, datalevel, numofpoints)

% Extraction utility that converts coefficient vector
% format to struct coefficient vector

% Projection
numofnodes = size(multileveltree, 1);
coeff = [];
levelcoeff = [];
dcoeffs = cell(numofnodes,1);
ccoeffs = cell(1);

% Up to level 0 of HB coefficients
indexvector = 1;
for n = numofnodes : -1 : 1 
    %if isempty(multileveltree{n,2}) == 0
    
        
        lengthlocalcoeffs = size(multileveltree{n,2},2);
        indexvector = [indexvector; (indexvector(end) + lengthlocalcoeffs)];
        % if isempty(multileveltree{n,2}) == 1; keyboard; end
        % dcoeffs{n} = coeffsvector();

    %end
end

for n = 1 : numofnodes
    % disp(n);
    %if isempty(multileveltree{n,2}) == 0
        dcoeffs{numofnodes - n + 1} = coeffsvector(indexvector(n) : indexvector(n+1) - 1)';
    %end
end


% Last level
ccoeffs = coeffsvector(indexvector(end) : length(coeffsvector))';
