function parameters = plotKL1D(parameters)

% Plot KL ML 1D tests

Qkl = parameters.KL.realization;
bump = parameters.KL.deviation;
x = parameters.KL.coord;
Q = parameters.ML.input;
levelcoeff = parameters.ML.Output.levelcoefficients;
coeff = parameters.ML.Output.coefficients;
coord = parameters.KL.coord;

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
title('KL Realization without Gaussian bump');
subplot(3,1,2);

plot(x, bump);


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



title('Gaussian bump');
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
title('KL Realization with Gaussian bump');

%%
figure(4)

maxlevel = max(levelcoeff);
numlevel = 5;
counter = 1;
subplot(numlevel + 2,1,counter);

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

ylim([0 1.1 * max(Qkl)])

yyaxis right
c = plot(x, parameters.KL.deviation, 'LineWidth',3);

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
outputcell{1} = coord;
outputcell{2} = parameters.KL.deviation;

for n = maxlevel : -1 : maxlevel - numlevel
    counter = counter + 1;
    subplot(numlevel + 2, 1, counter);
    
    a = stem(coeff(levelcoeff == n),'filled','MarkerSize',4);

    %a.Color = '#77AC30';
    
    hTitle  = title(['Level Coefficients =',num2str(n)]);
    %hTitle  = title(['']);
    hXLabel = xlabel(''                     );
    hYLabel = ylabel('');


    set( gca     , ...
    'FontName'   , 'Helvetica' );
    set([hTitle, hXLabel, hYLabel], ...
        'FontName'   , 'AvantGarde');
    set( hTitle                    , ...
        'FontSize'   , 12          , ...
        'FontWeight' , 'bold'      );

   set(gca, ...
   'Box'         , 'off'     , ...
   'TickDir'     , 'out'     , ...
   'TickLength'  , [.02 .02] , ...
   'XMinorTick'  , 'on'      , ...
   'YMinorTick'  , 'on'      , ...
   'YGrid'       , 'on'      , ...
   'XGrid'       , 'off'      , ...
   'XColor'      , [0.3 0.3 0.3], ...
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
print -bestfit -dpdf 1DKLML.pdf