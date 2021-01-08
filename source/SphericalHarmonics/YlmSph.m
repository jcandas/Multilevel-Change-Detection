function Y = YlmSph(n,m,theta,phi)


% Classical definition
Pn = legendre(n,cos(theta));

if m < 0 
     Pn = (-1)^m * (factorial(n - abs(m)) / factorial(n + abs(m))) * Pn(abs(m)+1,:);  
else
     Pn = Pn(abs(m) + 1 ,:);
end

Pn = Pn';

Y = sqrt( ( (2 * n + 1) / 4 * pi) *  (factorial(n - m) / factorial(n + m))) ...
            * Pn .* exp(i*m*phi);
        
 
% Other definition of spherical harmonics
%Pn = legendre(n,cos(theta));

%if m < 0 
%     Pn = (-1)^m * (factorial(n - abs(m)) / factorial(n + abs(m))) * Pn(abs(m)+1,:);  
%else
%     Pn = Pn(abs(m) + 1 ,:);
%end

%Pn = Pn';

%Y = sqrt( ( (2 * n + 1) / 4 * pi) *  (factorial(n - m) / factorial(n + m))) ...
%            * Pn .* exp(i*m*phi);