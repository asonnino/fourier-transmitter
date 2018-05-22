function [sn_re_th, sn_im_th] = IDFT(Y_re,Y_im,plot_data)
% IFFT Plot the ideal result and the computed theoretical output of the
%      IFFT block. 
%           
%   See also RESCALE_IFFT, PLOT_SINGLE.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



% Check argument's size
sizeCheck = ( size(Y_re) == size(Y_im) );
if(sizeCheck == 0)
    displays('Error - IDFT: wrong arguments size');
    return;
elseif(size(Y_re,2) ~= 1)
    displays('Error - IDFT: inputs must be column vectors');
    return;
end
    
% Initialize arguments
switch(nargin)
    case 3
        display = plot_data;
    case 2
        display = 1;
end


% Compute theoretical values
IFFT_SIZE = 16;
sn_th = zeros(size(Y_re)); 

for n=1:(size(Y_re,1)/IFFT_SIZE)
    index = 1+IFFT_SIZE*(n-1):IFFT_SIZE*n;
    sn_th(index,1) = ifft(Y_re(index,1)+1i*Y_im(index,1),IFFT_SIZE); 
end

sn_th = rescale_IFFT(sn_th);
sn_re_th = real(sn_th);
sn_im_th = imag(sn_th);
sn_power_th = sqrt(sn_re_th.^2 + sn_im_th.^2);


% Plot
if(display)
    % Plot sn_re
    plot_single(sn_re_th','IDFT - Real Part','pro');
    % Plot sn_im
    plot_single(sn_im_th','IDFT - Imag Part','pro');
    % Plot sn_power_th
    plot_single(sn_power_th','IDFT - Power','pro');
end

end


function y = rescale_IFFT(x)
% RESCALE_IFFT Rescale the MATLAB's fft output to match the experimental 
%             rescaling. 
%           
%   See also IFFT.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



    y = x .*2^(-5) .*2^4;

end