function Q = PolynomialMonomials(degree, coords, polymodel,datapoints)

% Compute vandemonde matrix for restricted polynomials

% If design matrix is available then 
if isfield(polymodel,'M') == true
    Q = polymodel.M(datapoints,:);
else 
    % Compute reduced set monomials evaluated at coordinate knots
    [n,dim] = size(coords);
    % I = polymodel.fun(degree, dim, polymodel.restrictedtensor);
    I = polymodel.indexset;
    Qd = I'; 
    Q = [];

    %% Compute Vandermond matrix
    for i = 1 : size(Qd,1),
        B = repmat(Qd(i,:), [size(coords,1) 1]);
        C = coords.^B;
        Q = [Q prod(C')'];
    end
end
