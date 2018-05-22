function [Y_re_th, Y_im_th] = SRRC_filter(X_re,X_im,H,plot_data)
% SRRC_FILTER Plot the ideal result and the computed theoretical output of
%             the SRRC filter block.  
%           
%   See also RESCALE_FILTER, PLOT_SINGLE.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



% Check argument's size
sizeCheck = ( ...
    size(X_re) == size(X_im) == size(H) ...
);
if(sizeCheck == 0)
    displays('Error - SRRC_FILTER: wrong arguments size');
    return;
elseif(size(X_re,2) ~= 1)
    displays('Error - SRRC_FILTER: inputs must be column vectors');
    return;
end

% Initialize arguments
switch(nargin)
    case 4
        display = plot_data;
    case 3
        display = 1;
end


% Compute theoretical values
Y_re_th = rescale_filter(X_re .* H);
Y_im_th = rescale_filter(X_im .* H);
Y_power_th = sqrt(Y_re_th.^2 + Y_im_th.^2);


% Plot
if(display)
    % Plot Y_re
    plot_single(Y_re_th','Filter - Real Part','pro');
    % Plot Y_im
    plot_single(Y_im_th','Filter - Imag Part','pro');
    % Plot Y_power_th
    plot_single(Y_power_th','Filter - Power','pro');
end

end


function y = rescale_filter(x)
% RESCALE_FFT Rescale the MATLAB's filter output to match the experimental 
%             rescaling. 
%           
%   See also FILTER.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



    y = x .*2^(-15);

end