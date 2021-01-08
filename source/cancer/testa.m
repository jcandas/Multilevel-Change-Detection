
%%
syms x;
s = [-10:0.01:10];
f = sqrt(10 + x^2) * exp(-x^2);
clear a

for n = 1:10
    
    disp(n)

    %g = diff(f,n); plot(s,double(subs(g,s))); a(n) = double(max(abs(subs(g,s))));
    g = diff(f,n); a(n) = double(max(abs(subs(g,s))));

end