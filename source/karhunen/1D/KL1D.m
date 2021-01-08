function parameters = KL1D(parameters); 

% Initialize Eigenspace
l = parameters.KL.l;
coord = parameters.KL.coord;
x = coord(:,1);
M = ones(size(x));

L = parameters.KL.L;
Lp = parameters.KL.Lp;

eigenlambda(1) = sqrt(sqrt(pi) * L / 2);

for i = 2 : l
    if floor(i/2) == i/2 
        phi = (1 / i) * sin ( floor(i/2) * pi * x / Lp );
    else
        phi = (1 / i) * cos ( floor(i/2) * pi * x / Lp ); 
    end
    eigenlambda(i) = sqrt(sqrt(pi) * L) * exp( - ( (floor(i/2) * pi * L)^2 ) / 8 );
    M = [M phi];
end
eigenlambda = eigenlambda';

parameters.KL.lambda = eigenlambda;
parameters.KL.M = M;



