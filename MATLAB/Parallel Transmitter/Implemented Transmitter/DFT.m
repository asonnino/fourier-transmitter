function [xk_re_th, xk_im_th] = DFT(I,Q,xk_re,xk_im,plot_data)
% FFT Plot the experimental result and the computed theoretical output of 
%     a selected input of the DFT block.  
%           
%   See also RESCALE_DFT, PLOT_COMP, PLOT_SINGLE, GENERATE_FFT_COEFF.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.2.0



% Check argument's size
sizeCheck = ( size(I) == size(Q) ) & ( size(xk_re) == size(xk_im) ) ...
    & ( size(xk_re) == size(I) );
if( ~(sizeCheck(1,1) && sizeCheck(1,2)) )
    display('Error - DFT: wrong arguments size');
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
n_samples = size(I,1);
xk_th = zeros(size(I)); 

[ccos,csin] = generate_DFT_coeff(FFT_SIZE);

for i=1:n_samples
   for k=1:FFT_SIZE
       xk_th(i,k) = sum( ...
           (I(i,:)+1i*Q(i,:)) .* (ccos(k,:)-1i*csin(k,:)) ...
       );
   end
end

xk_re_th = rescale_DFT(real(xk_th));
xk_im_th = rescale_DFT(imag(xk_th));


% Plot
if((elem <= n_samples) && (elem > 0))
    % Plot xk_re and xk_re_th
    plot_comp(xk_re(elem,:),xk_re_th(elem,:),'Data','MATLAB','DFT - Real Part');
    % Plot xk_im and xk_im_th
    plot_comp(xk_im(elem,:),xk_im_th(elem,:),'Data','MATLAB','DFT - Imag Part');
    
    % Plot the error between xk_re and xk_re_th
    plot_single(abs(xk_re(elem,:)-xk_re_th(elem,:)),'DFT Error - Real Part','error');
    % Plot the error between xk_im and xk_im_th
    plot_single(abs(xk_im(elem,:)-xk_im_th(elem,:)),'DFT Error - Imag Part','error');
end

end


function y = rescale_DFT(x)
% RESCALE_FFT Rescale the MATLAB's DFT output to match the experimental 
%             rescaling. 
%           
%   See also DFT.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



    y = x .*2^(-3);

end
