function [] = plot_comp(y1,y2,legend1,legend2,plot_title)
% PLOT_COMP Plot two signals and their spline interpolations on a standard
%           representation.
%
%   See also PLOT_SINGLE.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1


% Format check
if(size(y1) ~= size(y2))
    display('Error - PLOT_COMP: inputs must have the same size');
    return;
elseif(size(y1,1) ~= 1 || size(y1,2) < 2)
    display('Error - PLOT_COMP: inputs must be vectors');
    return;   
end

% Define axis and compute splines
x  = 0 : 1   : (size(y1,2)-1);
xx = 0 : 0.1 : (size(y1,2)-1);
yy1 = spline(x,y1,xx);
yy2 = spline(x,y2,xx);

% Create figure  
figure1 = figure;   

% Create axes
axes1 = axes('Parent',figure1,...
    'ZColor',[0.431372553110123 0.431372553110123 0.431372553110123],...
    'YColor',[0.431372553110123 0.431372553110123 0.431372553110123],...
    'XColor',[0.431372553110123 0.431372553110123 0.431372553110123],...
    'FontSize',18);
grid(axes1,'on');
hold(axes1,'on');

% Create title
title(plot_title,'FontSize',24,'FontName','Arial',...
    'Color',[0.243137255311012 0.243137255311012 0.243137255311012],...
'FontSize',24);

% Create spline plots
% plot(xx,yy1,'DisplayName','Input','LineWidth',2,...
%     'Color',[0.82352941 0.3254902 0.23529412]); % Orange
% plot(xx,yy1,'DisplayName','Input','LineWidth',2,...
%     'Color',[0.13725490 0.58431373 0.49019608]); % KIT green
plot(xx,yy2,'DisplayName','Input','LineWidth',2,...
    'Color',[0 0 0]);
plot(xx,yy1,'DisplayName','Input','LineWidth',1,'LineStyle','--',...
    'Color',[0 0 0]);

% Create data plot
% plot(x,y1,'MarkerSize',5,'Marker','*','LineStyle','none',...
%     'Color',[0.82352941 0.3254902 0.23529412]); % Orange
% plot(x,y1,'MarkerSize',5,'Marker','*','LineStyle','none',...
%     'Color',[0.13725490 0.58431373 0.49019608]); % KIT green
plot(x,y2,'MarkerSize',6,'Marker','*','LineStyle','none',...
    'Color',[0 0 0]);
plot(x,y1,'MarkerSize',6,'Marker','*','LineStyle','none',...
    'Color',[0 0 0]);

% Create legend
legend(legend1,legend2,'Location','northwest');
xlabel('samples')
ylabel('amplitude')
 
end