function [parameters] = KLWeinerSphere(parameters);

% Initialize Eigenspace
l = parameters.KL.l;
coord = parameters.KL.coord;
theta = coord(:,1);
phi = coord(:,2);
M = [];

% Compute eigenvalues
ht = @(x,n) acos(x) .* Pn(n,x);
for k = 0 : l,
     lambda(k + 1) = integral(@(x) ht(x,k),-1,1,'AbsTol',1e-6,'RelTol',1e-3);
end

maxlambda = max(abs(lambda));
tol = 1e-10;

% Create eigenfunctions
for k = 0 : l
    if (abs(lambda(k+1)) / maxlambda) > tol
        for m = -k:k
            Y0 = YlmSph(k,m,0,0);
            Y  = YlmSph(k,m,theta,phi);
            M  = [M Y-Y0];        
        end
    end
end

parameters.KL.lambda = lambda;
parameters.KL.M = M;
parameters.KL.tol = tol;

end

% Legendre
function output = Pn(n,x)
    output = double(legendreP(n,x));
end



