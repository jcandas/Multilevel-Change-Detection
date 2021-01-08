%% clear all;

 %ht = @(x,n) acos(x) .* Pn(n,x);

 %for n = 1 : 50,
 %    disp(n);
 %    q(n) = integral(@(x) ht(x,n),-1,1,'AbsTol',1e-6,'RelTol',1e-3);
 %end


%%
% theta = 0 : 0.05 : 2 * pi;
% phi =   0 : 0.05 : pi; 
% 
% ltheta = length(theta);
% lphi = length(phi);
% 
% n = 4;
% m = -2;
% 
% Y = Ylm(n,m,theta,phi);
% 
% [theta,phi] = meshgrid(theta, phi);
% [x,y,z] = sph2cart(phi(:),pi/2 - theta(:),abs(Y(:)));
% 
% 
% x = reshape(x, [ltheta, lphi]);
% y = reshape(y, [ltheta, lphi]);
% z = reshape(z, [ltheta, lphi]);
% 
% surf(x,y,z);
% axis equal
%%

% close all

%%
theta = linspace(0, pi, 400);
phi =   linspace(0, 2 * pi, 400); 

ltheta = length(theta);
lphi = length(phi);
[theta,phi] = meshgrid(theta, phi);

n = 10;
m = -5;

theta = theta(:);
phi = phi(:);

Y = YlmSph(n,m,theta,phi);

[x,y,z] = sph2cart(phi, pi/2 - theta, abs(Y(:)));

% DT = delaunayTriangulation(x,y,z);
% tetramesh(DT,'FaceAlpha',0.3);

figure(1)

x = reshape(x, [ltheta, lphi]);
y = reshape(y, [ltheta, lphi]);
z = reshape(z, [ltheta, lphi]);

surf(x,y,z);
axis equal

figure(2)

[theta,phi,triangles] = GridSphere(10000);
theta = deg2rad(theta);
phi = pi + deg2rad(phi);

theta = pi/2 - theta(:);
phi = phi(:);

n = 10;
m = -5;

Y = YlmSph(n,m,theta,phi);
% [x,y,z] = sph2cart(phi, pi/2 - theta, abs(Y(:)));
[x,y,z] = sph2cart(phi, pi/2 - theta, ones(length(Y(:)),1));

plot3(x,y,z,'.');

%%
%figure(5)
%gtheta = linspace(0, pi, 400);
%gphi =   linspace(0, 2 * pi, 400); 
%[gtheta,gphi] = meshgrid(gtheta, gphi);
%vq = griddata(theta,phi,abs(Y(:)),gtheta,gphi);
%[xq,yq,zq] = sph2cart(gphi, pi/2 - gtheta,vq);
%surf(gtheta,gphi,vq)





%%
figure(3);
B = [triangles(:,:,1); triangles(:,:,2); triangles(:,:,3)];
[P,Ia,Ib] = unique(B, 'rows', 'stable');
I = reshape(Ib,[ size(triangles(:,:,1),1) 3]);
TR = triangulation(I,P);
trimesh(TR);

%%
figure(4);
B = [triangles(:,:,1); triangles(:,:,2); triangles(:,:,3)];
[P,Ia,Ib] = unique(B, 'rows', 'stable');
I = reshape(Ib,[ size(triangles(:,:,1),1) 3]);
PA = P .* (abs(Y));
%PA = [x y z];
TR = triangulation(I,PA);
trimesh(TR);




%%
function output = Pn(n,x)
    output = double(legendreP(n,x));
end






