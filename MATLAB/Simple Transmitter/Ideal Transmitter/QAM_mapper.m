function [I, Q] = QAM_mapper(I,Q,plot_data)
% QAM_MAPPING Plot the experimental result of the QAM mapping block.
%           
%   See also PLOT_SINGLE.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



% Check argument's size
sizeCheck = ( size(I) == size(Q) );
if(sizeCheck == 0)
    displays('Error - QAM_MAPPER: wrong arguments size');
    return;
elseif(size(I,2) ~= 1)
    displays('Error - QAM_MAPPER: inputs must be column vectors');
    return;
end

% Initialize arguments
switch(nargin)
    case 3
        display = plot_data;
    case 2
        display = 1;
end


% Plot
if(display)
    % Plot I component
    plot_single(I','QAM Mapping - I component','rect pro');
    % Plot Q component
    plot_single(Q','QAM Mapping - Q component','rect pro');
end

end