close all;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot state-of-the-art summary
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Data
years = [2003 2010 2010.1 2012 2013 2015];
f     = [55 111.11 125 128.6 650 750];

% Splines
xx = years(1,1) : 0.1 : years(1,end);
yy = spline(years,f,xx);

% Create figure  
figure1 = figure;   

% Create axes
axes1 = axes('Parent',figure1,...
    'ZColor',[0.431372553110123 0.431372553110123 0.431372553110123],...
    'YColor',[0.431372553110123 0.431372553110123 0.431372553110123],...
    'XColor',[0.431372553110123 0.431372553110123 0.431372553110123],...
    'FontSize',18);
grid(axes1,'off');
hold(axes1,'on');
xlabel('years');
ylabel('top frequency [MHz]');

% Plot splines
plot(years,f,'DisplayName','Input','LineWidth',2,...
    'Color',[0 0 0]);

% Plot data
plot(years,f,'MarkerSize',15,'Marker','square','LineStyle','none',...
    'Color',[0 0 0]);

