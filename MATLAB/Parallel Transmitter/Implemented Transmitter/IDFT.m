function [sn_re_th, sn_im_th] = IDFT(Y_re,Y_im,sn_re,sn_im,plot_data)
% IFFT Plot the experimental result and the computed theoretical output of 
%      a selected input of the IDFT block. 
%           
%   See also RESCALE_IDFT, PLOT_COMP, PLOT_SINGLE.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.2.0



% Check argument's size
sizeCheck =( size(Y_re) == size(Y_im) ) & ( size(sn_re) == size(sn_im) )...
    & ( size(Y_re) == size(sn_re) );
if( ~(sizeCheck(1,1) && sizeCheck(1,2)) )
    display('Error - IDFT: wrong arguments size');
    return;
end
    
% Initialize arguments
switch(nargin)
    case 5
        elem = plot_data;
    case 4
        elem = 1;
end


% Compute theoretical values
FFT_SIZE = 16;
n_samples = size(Y_re,1);
sn_th = zeros(size(Y_re)); 

[ccos,csin] = generate_DFT_coeff(FFT_SIZE);

for i=1:n_samples
   for k=1:FFT_SIZE
       sn_th(i,k) = (1/FFT_SIZE) * sum( ...
           (Y_re(i,:)+1i*Y_im(i,:)) .* (ccos(k,:)+1i*csin(k,:)) ...
       );
   end
end

sn_re_th = rescale_IDFT(real(sn_th));
sn_im_th = rescale_IDFT(imag(sn_th));


% Plot
if((elem <= n_samples) && (elem > 0))
    % Plot xk_re and xk_re_th
    plot_comp(sn_re(elem,:),sn_re_th(elem,:),'Data','MATLAB','IDFT - Real Part');
    % Plot xk_im and xk_im_th
    plot_comp(sn_im(elem,:),sn_im_th(elem,:),'Data','MATLAB','IDFT - Imag Part');
    
    % Plot the error between xk_re and xk_re_th
    plot_single(abs(sn_re(elem,:)-sn_re_th(elem,:)),'IDFT Error - Real Part','error');
    % Plot the error between xk_im and xk_im_th
    plot_single(abs(sn_im(elem,:)-sn_im_th(elem,:)),'IDFT Error - Imag Part','error');
end

end


function y = rescale_IDFT(x)
% RESCALE_DFT Rescale the MATLAB's IDFT output to match the experimental 
%             rescaling. 
%           
%   See also DFT.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



    y = x .*2^(-3) .*2^(4);

end