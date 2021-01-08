function Y = Ylm(n,m,theta,phi)

theta = theta(:);
phi = phi(:)';
Pn = legendre(n,cos(theta));

if m >= 0 
     Pn = (-1)^m * (factorial(n - m) / factorial(n - m)) * Pn(abs(m)+1,:);  
else
     Pn = Pn(abs(m)+1,:);  
end



% sign change required for odd positive m
%if m >= 0
%  Pn = Pn(abs(m)+1,:);
%else
%  Pn = (-1)^m * (factorial(n - m) / factorial(n - m)) * Pn(abs(m)+1,:);  
%end

Y = sqrt( ( (2 * n + 1) / 4 * pi) *  (factorial(n - m) / factorial(n - m))) ...
            * Pn' * exp(i*m*phi);