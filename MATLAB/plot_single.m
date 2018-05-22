function [] = plot_single(y,plot_title,type)
% PLOT_COMP Plot a signal and its spline interpolation in many different 
%           representation.
%
%   See also PLOT_COMP.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



% Format check
if(size(y,1) ~= 1 || size(y,2) < 2)
    display('Error - PLOT_SINGEL: input must be a vector');
    return;   
end

% Define plot parameters
STANDARD = 'standard';
RECT     = 'rect';
ERROR    = 'error';
PRO      = 'pro';
RECT_PRO = 'rect pro';

% Initialize defaults arguments
plot_type = STANDARD;

% Check arguments
switch(nargin)
    case 2
        plot_type = STANDARD;
    case 3
        plot_type = type;
end

% Define axis and compute splines
x  = 0 : 1   : (size(y,2)-1);
xx = 0 : 0.1 : (size(y,2)-1);
yy = spline(x,y,xx);

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
xlabel('samples')
ylabel('amplitude')

% Plot 
if(strcmp(plot_type,STANDARD))   
    % Create spline plot
    plot(xx,yy,'DisplayName','Input','LineWidth',2,...
        'Color',[0.82352941 0.3254902 0.23529412]); 
    % Create data plot
    plot(x,y,'MarkerSize',5,'Marker','*','LineStyle','none',...
        'Color',[0.82352941 0.3254902 0.23529412]); 
    
elseif(strcmp(plot_type,RECT))
    stairs(x,y,'DisplayName','Input','LineWidth',2,...
        'Color',[0.82352941 0.3254902 0.23529412]);
    
elseif(strcmp(plot_type,ERROR))
%     plot(x,y,'DisplayName','Input','LineWidth',2,...
%         'Color',[0.82352941 0.3254902 0.23529412]); % Orange
%     plot(x,y,'DisplayName','Input','LineWidth',2,...
%         'Color',[0.13725490 0.58431373 0.49019608]); % KIT green
    plot(x,y,'DisplayName','Input','LineWidth',2,...
        'Color',[0 0 0]); 
    ylabel('magnitude')
    
elseif(strcmp(plot_type,PRO))
%     plot(xx,yy,'DisplayName','Input','LineWidth',1,...
%         'Color',[0 0 0]);
   plot(xx,yy,'DisplayName','Input','LineWidth',2,...
        'Color',[0.13725490 0.58431373 0.49019608]); % KIT green
    
elseif(strcmp(plot_type,RECT_PRO))
%     stairs(x,y,'DisplayName','Input','LineWidth',2,...
%         'Color',[0.13725490 0.58431373 0.49019608]); % KIT green
    stairs(x,y,'DisplayName','Input','LineWidth',2,...
        'Color',[0 0 0]);
    
else
    % Display warning
    display('Error: plot type %s not recognised',plot_type);
    % Create spline plot
    plot(xx,yy,'DisplayName','Input','LineWidth',2,...
        'Color',[0.82352941 0.3254902 0.23529412]);
    % Create data plot
    plot(x,y,'MarkerSize',5,'Marker','*','LineStyle','none',...
        'Color',[0.82352941 0.3254902 0.23529412]);
end



end