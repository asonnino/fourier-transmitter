function [] = plot_exp(constraints,data)

% Define axis and compute splines
constraits_in_frequency = 1 ./ constraints .* 10^3;   % in MHz
data_in_frequency = 1 ./ data .* 10^3;                % in MHz
xx = constraits_in_frequency(1,1) : 0.1 : constraits_in_frequency(1,end);
yy = spline(constraits_in_frequency,data_in_frequency,xx);

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
%title('Fabric - Mults Design Performances','FontSize',24,'FontName','Arial',...
%    'Color',[0.243137255311012 0.243137255311012 0.243137255311012],...
%'FontSize',24);
xlabel('clock constraints [MHz]');
ylabel('top frequency [MHz]');

% Plot
plot(xx,yy,'DisplayName','Input','LineWidth',2,'Color',[0 0 0]);
hold on;
plot(constraits_in_frequency,data_in_frequency,'*k');

end
