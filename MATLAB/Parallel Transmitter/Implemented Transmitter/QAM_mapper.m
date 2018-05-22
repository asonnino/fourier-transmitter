function [I, Q] = QAM_mapper(I,Q,plot_data)
% QAM_MAPPING Plot the experimental result of of a selected input of the 
%             QAM mapping block.
%           
%   See also PLOT_SINGLE.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.2.1



% Check argument's size
sizeCheck = ( size(I) == size(Q) );
if( ~(sizeCheck(1,1) && sizeCheck(1,2)) )
    display('Error - QAM_MAPPER: wrong arguments size');
    return;
end

% Initialize arguments
switch(nargin)
    case 3
        elem = plot_data;
    case 2
        elem = 1;
end


% Plot
if((elem <= size(I,1)) && (elem > 0))
    % Plot I component
    plot_single(I(elem,:),'QAM MAPPER - I component','rect pro');
    % Plot Q component
    plot_single(Q(elem,:),'QAM MAPPER - Q component','rect pro');
end

end