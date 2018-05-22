function [MATLAB_data,out_model] = testbench(plot_data)
% TESTBENCH Simulate completely the QAM modulator by plotting and 
%           outputing the ideal value. 
%           
%   See also QAM_MAPPING, FFT, SRRC_FILTER, IFFT, MODULATOR, TRANSMITTER,
%            FIND_OFFSET.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



close all;

% Initialize arguments
switch(nargin)
    case 1
        display = plot_data;
    case 0
        display = 1;
end

% Import signals
data = signals();
DATA_NUMBER = 80; % !!! must be a multiple of 16

QAM_MAPPING_OFFSET = find_offset(data(:,1));
I     = data((QAM_MAPPING_OFFSET:QAM_MAPPING_OFFSET+DATA_NUMBER-1),3);
Q     = data((QAM_MAPPING_OFFSET:QAM_MAPPING_OFFSET+DATA_NUMBER-1),4);

FFT_OFFSET = min(find_offset(data(:,5)),find_offset(data(:,6)));
H    = data((FFT_OFFSET:FFT_OFFSET+DATA_NUMBER-1),7);

IFFT_OFFSET = min(find_offset(data(:,10)),find_offset(data(:,11)));
cos   = data((IFFT_OFFSET:IFFT_OFFSET+DATA_NUMBER-1),12);
sin   = data((IFFT_OFFSET:IFFT_OFFSET+DATA_NUMBER-1),13);



% QAM mapping
[I,Q] = QAM_mapper(I,Q,display);

% FFT
[xk_re_th, xk_im_th] = DFT(I,Q,display);

% Filter
[Y_re_th, Y_im_th] = SRRC_filter(xk_re_th,xk_im_th,H,display);

% IFFT
[sn_re_th, sn_im_th] = IDFT(Y_re_th,Y_im_th,display);

% Modulator
[out_th] = modulator(sn_re_th,sn_im_th,cos,sin,display); 

% Transmitter
[out_model] = transmitter(I,Q,H,cos,sin,display);



% Output Results
MATLAB_data     = [...
    I,Q,xk_re_th,xk_im_th,Y_re_th,Y_im_th,sn_re_th,sn_im_th,out_th ...
];
 

end

function offset = find_offset(x)
% FIND OFFSET determine the offset introduced by hardware latency.
%           
%   See also TRANSMITTER.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



% Check input format
if(size(x,2) ~= 1)
    display('Error - TESTBENCH: input must be a column vector');
    return;
end

% Determin offset
for i=1:size(x,1)
    if(x(i,1) ~= 0)
        offset = i;
        return;
    end
end

end