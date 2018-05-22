function [Y_re_th, Y_im_th] = SRRC_filter(X_re,X_im,Y_re,Y_im,plot_data)
% SRRC_FILTER Plot the experimental result and the computed theoretical 
%             output of a selected input of the SRRC filter block.  
%           
%   See also RESCALE_FILTER, GENERATE_FILTER_COEFF, PLOT_COMP.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.2.0



% Check argument's size
sizeCheck = ( size(X_re) == size(X_im) ) & ( size(Y_re) == size(Y_im) ) ...
    & ( size(X_re) == size(Y_re) );
if( ~(sizeCheck(1,1) && sizeCheck(1,2)) )
    display('Error - SRRC_FILTER: wrong arguments size');
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
H = generate_filter_coeff();

Y_re_th = zeros(size(X_re));
Y_im_th = zeros(size(X_im));
for i=1:size(X_re,1)
    Y_re_th(i,:) = rescale_filter(X_re(i,:) .* H');
    Y_im_th(i,:) = rescale_filter(X_im(i,:) .* H');
end


% Plot
if((elem <= size(Y_re,1)) && (elem > 0))
    % Plot Y_re and Y_re_th
    plot_comp(Y_re(elem,:),Y_re_th(elem,:),'Data','MATLAB','Filter - Real Part');
    % Plot Y_im and Y_im_th
    plot_comp(Y_im(elem,:),Y_im_th(elem,:),'Data','MATLAB','Filter - Imag Part');
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



    y = x .*2^(-1);

end


function [H] = generate_filter_coeff()
% GENERATE_FILTER_COEFF Compute the SRRC_FILTER coefficients to manualy  
%                       process the filter operation. 
%           
%   See also SRRC_FILTER.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.1.1

H = [...
     0.022507907903927645; ...
     0.028298439380057477; ...
    -0.076801948979409798; ...
    -0.037500771921555154; ...
     0.3076724792547561; ...
     0.54098593171027443; ...
     0.3076724792547561; ...
    -0.037500771921555154; ...
    -0.076801948979409798; ...
     0.028298439380057477; ...
     0.022507907903927645; ...
     0;...
     0;...
     0;...
     0;...
     0;...
];

end
