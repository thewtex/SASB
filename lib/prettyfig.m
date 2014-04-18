function prettyfig(w,h)
% PRETTYFIG set asteatics of figures
% w: width of printet image in centimeters (default 14 cm)
% h: height of printet image in centimeters (default 3/4 of w)

if nargin<1, w = 14, end
if nargin<2, h = w*3/4, end

set( gca, ...
    'FontName'   , 'Helvetica' ,...
    'FontSize'   , 9          ,...
    'LineWidth'  , 1           );

set( [get(gca,'Title'), get(gca,'XLabel'), get(gca,'YLabel')], ...
    'FontName'   , 'AvantGarde');

set( get(gca,'Title')          , ...
    'FontSize'   , 13          , ...
    'FontWeight' , 'bold'      );

set(findall(gca,'Type','text') , ...
    'FontSize'   ,  9         , ...
    'FontName'   , 'Helvetica' );

set(gca, ...
    'Box'        , 'off'       , ...
    'TickDir'    , 'out'       , ...
    'TickLength' , [.02 .02]   , ...
    'XMinorTick' , 'on'        , ...
    'YMinorTick' , 'on'        , ...
    'XColor'     , [.3 .3 .3]  , ...
    'YColor'     , [.3 .3 .3]  );

set(gca, 'ColorOrder', linspecer(7));

%# figure size printed on paper
set(gcf, 'PaperUnits','centimeters')
% set(gcf, 'PaperSize',[8 8])
set(gcf, 'PaperOrientation','portrait')
set(gcf, 'PaperPosition',[0 0 w h])

% Figure size on screen and same on print
% set(gcf, 'Units','centimeters', 'Position',[0 0 5 10])
% set(gcf, 'PaperPositionMode','auto')

% colormap(flipud(gray));

end

