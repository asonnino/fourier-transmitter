function [out_th] = modulator(sn_re,sn_im,out,plot_data)
% MODULATOR Plot the experimental result and the computed theoretical  
%           output of first input set of the modulator block. 
%           
%   See also RESCALE_MOD, GENERATE_CARRIERS, PLOT_COMP.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.2.0


% Check argument's size
sizeCheck =( size(sn_re) == size(sn_im) ) & ( size(sn_re) == size(out) );
if( ~(sizeCheck(1,1) && sizeCheck(1,2)) )
    display('Error - MODULATOR: wrong arguments size');
    return;
end
    
% Initialize arguments
switch(nargin)
    case 4
        elem = plot_data;
    case 3
        elem = 1;
end


% Compute theoretical values
F = 100;
N = 16;
[cos_carrier,sin_carrier] = generate_carriers(F,N);

out_th = zeros(size(sn_re));
for i=1:size(sn_re,1)
    % calculate index
    j = mod(i,size(cos_carrier,1));
    index = (j-1)*N+1 : (j-1)*N+1 + (N-1);
    % assign output
    out_th(i,:) = rescale_mod(...
        sn_re(i,:) .* cos_carrier(index,1)' - ...
        sn_im(i,:) .* sin_carrier(index,1)'...
    );
end


% Plot
if((elem <= size(sn_re,1)) && (elem > 0))
    % Plot out and out_th
    plot_comp(out(elem,:),out_th(elem,:),'Data','MATLAB','Modulator');
end

end


function y = rescale_mod(x)
% RESCALE_FFT Rescale the MATLAB's modulator output to match the 
%             experimental rescaling. 
%           
%   See also MODULATOR.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



    y = x .*2^(-2);

end


function [cos_carrier,sin_carrier] = generate_carriers(f,n)
% GENERATE_DFT_COEFF Compute the MODULATOR coefficients to manualy process 
%                    the modulation. 
%           
%   See also MODULATOR.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1

% Number of samples
n_samples = 4*f; % avoid aliasing
for i=0:(n-1)
    if(mod(n_samples,n) == 0) % rest of division
        break;
    end
    n_samples = n_samples+1;
end

% Time specifications:
StopTime = 1/f;                      % seconds
dt = StopTime/n_samples;             % interval between samples
t = (0:dt:StopTime - dt)';           % seconds
% Sine wave:
cos_carrier = cos(2*pi*f*t);
sin_carrier = sin(2*pi*f*t);

end