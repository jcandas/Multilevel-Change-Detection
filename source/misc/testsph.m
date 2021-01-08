% create a 2D grid
close all

n = 3;
m = -2;

th = linspace(0,pi,100);    % inclination
phi = linspace(0,2*pi,100); % azimuth
[th,phi] = meshgrid(th,phi);
% compute spherical harmonic of degree 3 and order 1
Y2 = harmonicY(n,m,th,phi);
% plot the magnitude
[x,y,z] = sph2cart(phi,pi/2-th,abs(Y2));
surf(x,y,z,abs(Y2));