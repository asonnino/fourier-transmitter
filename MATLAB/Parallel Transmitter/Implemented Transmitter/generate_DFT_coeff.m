function [ccos,csin] = generate_DFT_coeff(DFT_size)
% GENERATE_DFT_COEFF Compute the DFT coefficients to manualy process the 
%                    DFT. 
%           
%   See also DFT.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1
        
    ccos = zeros(DFT_size,DFT_size);
    csin = zeros(DFT_size,DFT_size);
    
    for k=0:(DFT_size-1)
        for n=0:(DFT_size-1)
            ccos(k+1,n+1) = cos(2*pi*k*n/DFT_size);
            csin(k+1,n+1) = sin(2*pi*k*n/DFT_size);
        end
    end

end