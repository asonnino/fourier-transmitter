function [xk_re_th, xk_im_th] = DFT(I,Q,plot_data)
% FFT Plot the ideal result and the computed theoretical output of the FFT 
%     block.  
%           
%   See also RESCALE_FFT, PLOT_SINGLE.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



% Check argument's size
sizeCheck = ( size(I) == size(Q) );
if(sizeCheck == 0)
    displays('Error: - DFT wrong arguments size');
    return;
elseif(size(I,2) ~= 1)
    displays('Error - DFT: inputs must be column vectors');
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
FFT_SIZE = 16;
xk_th = zeros(size(I)); 

for k=1:(size(I,1)/FFT_SIZE)
    index = 1+FFT_SIZE*(k-1):FFT_SIZE*k;
    xk_th(index,1) = fft(I(index,1)+1i*Q(index,1),FFT_SIZE); 
end

xk_th = rescale_FFT(xk_th);
xk_re_th = real(xk_th);
xk_im_th = imag(xk_th);
xk_power_th = sqrt(xk_re_th.^2 + xk_im_th.^2);


% Plot
if(display)
    % Plot xk_re_th
    plot_single(xk_re_th','DFT - Real Part','pro');
    % Plot xk_im_th
    plot_single(xk_im_th','DFT - Imag Part','pro');
    % Plot xk_power_th
    plot_single(xk_power_th','DFT - Power','pro');
end

end


function y = rescale_FFT(x)
% RESCALE_FFT Rescale the MATLAB's fft output to match the experimental 
%             rescaling. 
%           
%   See also FFT.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



    y = x .*2^(-5);

end