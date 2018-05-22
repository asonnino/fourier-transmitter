function [out_th] = modulator(sn_re,sn_im,cos,sin,plot_data)
% MODULATOR Plot the ideal result and the computed theoretical  
%           output of the modulator block. 
%           
%   See also RESCALE_MOD, PLOT_SINGLE.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



% Check argument's size
sizeCheck = ( ...
    size(sn_re) == size(sn_im) == size(cos) == size(sin) ...
);
if(sizeCheck == 0)
    displays('Error - MODULATOR: wrong arguments size');
    return;
elseif(size(sn_re,2) ~= 1)
    displays('Error - MODULATOR: inputs must be column vectors');
    return;
end

% Initialize arguments
switch(nargin)
    case 5
        display = plot_data;
    case 4
        display = 1;
end


% Compute theoretical values
out_th = rescale_mod(sn_re .* cos - sn_im .* sin);


% Plot
if(display)
    % Plot out_th
    plot_single(out_th','Modulator','pro');
end

end


function y = rescale_mod(x)
% RESCALE_FFT Rescale the MATLAB's modulator output to match the 
%             experimental rescaling. 
%           
%   See also MODULATOR.
%
% AUTHOR  Sonnino Alberto.
% VERSION 15.8.0



    y = x .*2^(-16);

end