function parameters = KLSPrealization(parameters)


% Generate realization of Spherical Fraction Brownian Motion
lambda = parameters.KL.lambda;
M = parameters.KL.M;
l = parameters.KL.l;
width = parameters.KL.plotwidth;
tol = parameters.KL.tol;

output = 0;
count = 1;
maxlambda = max(abs(lambda));


for k = 0 : l
    if (abs(lambda(k+1)) / maxlambda) > tol
        % Generate random
        d = lambda(k+1);
        for m = -k:k
            e(count) = randn(1);
            output = output + (sqrt(-pi * d) * e(count) * M(:,count));
            %disp([e norm(abs(output))])
            count = count + 1;
        end
    end
end

parameters.KL.realization = output;
parameters.ML.input = output;

% Plot Figures
if parameters.KL.plotrealization == true;
    
    % Plot Realization bary centers
    figure(1);
    coord = parameters.KL.coord;
    theta = coord(:,1);
    phi   = coord(:,2);
    
    %[x,y,z] = sph2cart(phi, pi/2 - theta, abs(output(:)) );
    [x,y,z] = sph2cart(phi, pi/2 - theta, ones(length(output),1));    
    plot3(x,y,z,'.','Color',[0,0,255]/255,'MarkerSize',3);
    hold on;
   
    % Plot Realization surface
    coordplot = parameters.KL.coordplot;
    theta = coordplot(:,1);
    phi   = coordplot(:,2);

    % Create plot out sphere
    count = 1;
    output = 0;
    
    % Create eigenfunctions for new plot
    M = [];
    for k = 0 : l
        if (abs(lambda(k+1)) / maxlambda) > tol
            for m = -k:k
                Y0 = YlmSph(k,m,0,0);
                Y  = YlmSph(k,m,theta,phi);
                M  = [M Y-Y0];        
            end
        end
    end
    
    for k = 0 : l
        if (abs(lambda(k+1)) / maxlambda) > tol
            d = lambda(k+1);
            for m = -k:k
                output = output + (sqrt(-pi * d) * e(count) * M(:,count));
                count = count + 1;
            end
        end
    end
    
    
[x,y,z] = sph2cart(phi, pi/2 - theta, abs(output(:)));

X = reshape(x,[width width]);
Y = reshape(y,[width width]);
Z = reshape(z,[width width]);
surf(X,Y,Z,'FaceAlpha',0.3);
colormap summer
shading interp
    
hold off
axis vis3d
axis equal

limsize = 6;
xlim([-limsize limsize]);
ylim([-limsize limsize]);
zlim([-limsize limsize]);

axis off

% Save to PDF

x0=0;
y0=0;
width=1200;
height=1200;
set(gcf,'units','points','position',[x0,y0,width,height])
print -dpdf KLSH-Realization.pdf

parameters.KL.plot.SPrealization = output;    

end

