%% Data and parameters
clc;
clear all;
close all;

degree = []; % Dummy variable, not used in this code.
numofpoints = 500;

d = 1;
data = linspace(0,d,numofpoints)';
n = 10;
x = linspace(0,d,numofpoints);
M = ones(size(x'));

%Lp = 1/4;
%L = 1/4;

Lc = 0.01;
Lp = max(d,2 * Lc);
L  = Lc / Lp;

%for i =  2 : n
%    if floor(i/2) == i/2 
%        phi = (1 / i) * sin ( floor(i/2) * pi * x / Lp );
%        %disp('even');
%    else
%        %disp('odd');
%        phi = (1 / i) * cos ( floor(i/2) * pi * x / Lp ); 
%    end
%    M = [M phi'];
%end

eigenlambda(1) = sqrt(sqrt(pi) * L / 2);

for i = 2 : n
    if floor(i/2) == i/2 
        phi = (1 / i) * sin ( floor(i/2) * pi * x / Lp );
    else
        phi = (1 / i) * cos ( floor(i/2) * pi * x / Lp ); 
    end
    eigenlambda(i) = sqrt(sqrt(pi) * L) * exp( - ( (floor(i/2) * pi * L)^2 ) / 8 );
    M = [M phi'];
end
eigenlambda = eigenlambda';


% Optional design matrix
polymodel.M = M;

% Number of columns in the design matrix
params.indexsetsize = n;

%%

% Create Multilevel Binary tree
fprintf('\n');
fprintf('Create KDd tree ---------------------------------\n');
tic;
[datatree, sortdata] = make_tree(data,@split_KD,params);
toc;

% Create multilevel basis
fprintf('\n');
fprintf('Create multilevel basis ------------------------\n');
tic;
[multileveltree, ind, datacell, datalevel]  = multilevelbasis(datatree, sortdata, degree, polymodel);
toc;

%% Run transform with random data
fprintf('\n');
fprintf('Test transform ---------------------------------\n');

%Q = polymodel.M * rand(n,1);

%Orginal realization of the stochastic process
cte = sqrt(3) * 2 * (rand(n,1) - 1/2);
Q = 1 + polymodel.M * (cte .* eigenlambda);


figure(1);
plot(x,Q);
title('KL Realization');


%% Metrics
numvecs = size(Q,2);
maxerror = inf;
maxwaverror = inf;

tic;
for n = 1 : numvecs
    [coeff, levelcoeff, dcoeffs, ccoeffs] = hbtrans(Q(:,n), multileveltree, ind, datacell, datalevel);
    Qv = invhbtrans(dcoeffs, ccoeffs, multileveltree, ind, datacell, datalevel, numofpoints);
    polyerror(n) = norm(Q(:,n) - Qv, 2) / norm(Q(:,n));
    wavecoeffnorm(n) = norm(coeff(1 : end - params.indexsetsize),'inf')/norm(Q(:,n));
end
t = toc;

fprintf('\n');
fprintf('Results: Num of tests = %d, Max Relative Error = %e \n', numvecs, max(polyerror));
fprintf('         Relative HBcoefficientsnorm =  %e \n', max(wavecoeffnorm));
fprintf('Total timing = %d seconds \n',t);
tic;
[coeff, levelcoeff, dcoeffs, ccoeffs] = hbtrans(Q(:,n), multileveltree, ind, datacell, datalevel);
t = toc;
fprintf('One Hierarchical Basis transform time = %d seconds \n',t);

% Test format change from vector of coefficients to struct
totalerror = 0;
[a b] = hbvectortocoeffs(coeff, multileveltree, ind, datacell, datalevel, numofpoints);
for i = 1 : length(dcoeffs)
   totalerror = totalerror + (norm(a{i} -  dcoeffs{i}));
end
totalerror = totalerror + (norm(b -  ccoeffs));
fprintf('Total error = %e \n', totalerror);

%% Plot coefficients

figure(2)
maxlevel = max(levelcoeff);
numlevel = 3;
counter = 1;
subplot(numlevel + 2,1,counter);
plot(x,Q);
for n = maxlevel : -1 : maxlevel - numlevel
    counter = counter + 1;
    subplot(numlevel + 2, 1, counter);  
    stem(coeff(levelcoeff == n));
    title(['Level Coefficients = ',num2str(n)]);
end

%% Run trans
fprintf('\n');
fprintf('Add Bump to KL  --------------------------------\n');

% Random realization
% Q = polymodel.M * rand(size(polymodel.M,2),1);

% Add Gaussian "bump" to the data
sbump = 0.5;
Qkl = Q;
%sigma = 0.0001;
sigma = 0.001;
maxbump = 0.05;
bump = maxbump * exp( - ((x' - sbump).^2)/sigma);

bump(1:150) = 0;
bump(350:end) = 0;


Q = Q + bump;

numvecs = size(Q,2);
maxerror = inf;
maxwaverror = inf;

tic;
for n = 1 : numvecs
    [coeff, levelcoeff, dcoeffs, ccoeffs] = hbtrans(Q(:,n), multileveltree, ind, datacell, datalevel);
    Qv = invhbtrans(dcoeffs, ccoeffs, multileveltree, ind, datacell, datalevel, numofpoints);
    polyerror(n) = norm(Q(:,n) - Qv, 2) / norm(Q(:,n));
    wavecoeffnorm(n) = norm(coeff(1 : end - params.indexsetsize),'inf')/norm(Q(:,n));
end
t = toc;

%%
figure(3);
subplot(3,1,1);
b = plot(x,Qkl);

%b.Color = 	'#0072BD';
set( gca     , ...
    'FontName'   , 'Helvetica' );
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'YTick'       , 0:.5:1.5, ...
  'LineWidth'   , 1         );

axis([0 1 0 2])
%title('KL Realization without Gaussian bump');
subplot(3,1,2);
plot(x, maxbump * exp( - ((x' - sbump).^2)/sigma));


%b.Color = 	'#0072BD';
set( gca     , ...
    'FontName'   , 'Helvetica' );
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'YTick'       , 0:.5:1.5, ...
  'LineWidth'   , 1         );



%title('Gaussian bump');
subplot(3,1,3);
plot(x,Q);


%b.Color = 	'#0072BD';
set( gca     , ...
    'FontName'   , 'Helvetica' );
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'YTick'       , 0:.5:1.5, ...
  'LineWidth'   , 1         );


axis([0 1 0 2])
%title('KL Realization with Gaussian bump');

%%
figure(4)

maxlevel = max(levelcoeff);
numlevel = 5;
counter = 1;
subplot(numlevel + 2,1,counter);
%plot(x, maxbump * exp( - ((x' - sbump).^2)/sigma));

yyaxis left
b = plot(x, Q);

%b.Color = 	'#0072BD';
set( gca     , ...
    'FontName'   , 'Helvetica' );

hold on

d = plot(x, Qkl,'--');


set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'YTick'       , 0:0.5:2, ...
  'LineWidth'   , 1         );

ylim([0 1.25])

yyaxis right
c = plot(x, maxbump * exp( - ((x' - sbump).^2)/sigma), 'LineWidth',3);

%c.Color = 	'#EDB120';
set( gca     , ...
    'FontName'   , 'Helvetica' );

set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'YTick'       , 0:0.1:0.5, ...
  'LineWidth'   , 1         );

ylim([0 0.25])


outputcell = cell(numlevel + 2,2);
outputcell{1} = x';
outputcell{2} = maxbump * exp( - ((x' - sbump).^2)/sigma);

for n = maxlevel : -1 : maxlevel - numlevel
    counter = counter + 1;
    subplot(numlevel + 2, 1, counter);
    
    
    
    
    
    a = stem(coeff(levelcoeff == n),'filled','MarkerSize',4);

    %a.Color = '#77AC30';
    
%hTitle  = title(['Level Coefficients = ',num2str(n)]);
%hTitle  = title(['']);
%hXLabel = xlabel('Coefficient'                     );
%hYLabel = ylabel('');


set( gca     , ...
    'FontName'   , 'Helvetica' );
%set([hTitle, hXLabel, hYLabel], ...
%    'FontName'   , 'AvantGarde');
%set( hTitle                    , ...
%    'FontSize'   , 12          , ...
%    'FontWeight' , 'bold'      );

set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XGrid'       , 'off'      , ...
  'XColor'      , [1 1 1], ...
  'YColor'      , [.3 .3 .3], ...
  'YTick'       , 0:500:2500, ...
  'LineWidth'   , 1         );

%set(gca, 'xtick', []);

    
    outputcell{counter + 1} = coeff(levelcoeff == n);
    xlim([0 length(coeff(levelcoeff == n))]);
    
end


x0=10;
y0=10;
width=400;
height=600;
set(gcf,'units','points','position',[x0,y0,width,height])

%set(gcf, 'PaperPositionMode', 'auto');
print -bestfit -dpdf 1DKLML-5.pdf

