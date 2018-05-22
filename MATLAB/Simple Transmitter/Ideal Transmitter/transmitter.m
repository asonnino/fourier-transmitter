function [out_model] = transmitter(I,Q,H,cos,sin,plot_data)
% TRANSMITTER Plot the ideal result and the computed theoretical output
%             of the transmitter block. 
%           
%   See also QAM_MAPPING, FFT, SRRC_FILTER, IFFT, MODULATOR, PLOT_SINGLE.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



% Initialize arguments
switch(nargin)
    case 6
        display = plot_data;
    case 5
        display = 1;
end


% Compute theoretical values
[tmp1, tmp2] = QAM_mapper(I,Q,0);
[tmp1, tmp2] = DFT(tmp1,tmp2,0);
[tmp1, tmp2] = SRRC_filter(tmp1,tmp2,H,0);
[tmp1, tmp2] = IDFT(tmp1,tmp2,0);
out_model    = modulator(tmp1,tmp2,cos,sin,0); 


% Plot
if(display)
    % Plot out_model
    plot_single(out_model','Transmitter','pro');
end

end