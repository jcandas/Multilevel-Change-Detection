function parameters = plotKLSP(parameters)

% Upload variables
multileveltree = parameters.ML.multilevetree;
dcoeffs=parameters.ML.Output.Dcoefficients;
nodeindex = parameters.ML.Output.nodeindex;
leveltree = [multileveltree{:,5}]';
width = parameters.KL.plotwidth;
coord = parameters.KL.coord;
plotbump = parameters.KL.plotdeviation;
surfacerealization = parameters.KL.plot.SPrealization;    

% Plot ML on sphere
tol = parameters.ML.plot.tol;


% Plot Realization
coordplot = parameters.KL.coordplot;
theta = coordplot(:,1);
phi   = coordplot(:,2);

% Plot Realization with bump
figure(3)
[x,y,z] = sph2cart(phi, pi/2 - theta, abs(surfacerealization));    
X = reshape(x,[width width]);
Y = reshape(y,[width width]);
Z = reshape(z,[width width]);
surf(X,Y,Z,'FaceAlpha',0.3);
colormap summer
shading interp
axis equal
axis off
hold on

% Plot sphere with bump
% Plot patches of coefficient locations
numlevel = parameters.ML.plot.numlevel;
maxlevel = max(leveltree);

[x,y,z] = sph2cart(phi, pi/2 - theta, plotbump + ones(length(phi(:)),1));    
X = reshape(x,[width width]);
Y = reshape(y,[width width]);
Z = reshape(z,[width width]);

for level = maxlevel : -1 : maxlevel - numlevel 

    h = figure;
    %subplot(1, numlevel + 1, maxlevel - level + 1)
    surf(X,Y,Z,'FaceAlpha',0.3);
    colormap summer
    shading interp
    axis equal
    axis off
    axis vis3d
    hold on
    
    for n = 1 : length(leveltree)
        if leveltree(n) == level       
            listI = nodeindex(n);
            listI = listI{1};
            val = norm(dcoeffs{n});
            if val > tol
            selectcoord = coord(listI,:);
            theta = selectcoord(:,1);
            phi = selectcoord(:,2);
            [x,y,z] = sph2cart(phi, pi/2 - theta, ones(length(phi(:)),1));    
            plot3(x,y,z,'b.');
            end
        end
    end
    
    hold off
    x0=0;
    y0=0;
    width=600;
    height=600;
    set(h,'units','points','position',[x0,y0,width,height])
    %set(gcf,'PaperPosition',[0 0 7 2]);
    %print(gcf, '-dpdf', '-bestfit', ['ML-Coeff-',num2str(level),'.pdf']);
    print(h,'-dpdf', '-bestfit','-r150',['ML-Coeff-',num2str(level),'.pdf']);
end

%%


%print -dpdf -bestfit -r600 KLSH-MLCoeff.pdf




