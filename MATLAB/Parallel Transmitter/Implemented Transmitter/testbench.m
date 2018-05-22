function [exp_data,MATLAB_data,out_model] = testbench(plot_data)  
% TESTBENCH Simulate completely the QAM modulator by plotting and 
%           outputing the experimental data and the computed theoretical 
%           values.
%           
%   See also QAM_MAPPING, FFT, SRRC_FILTER, IFFT, MODULATOR, TRANSMITTER,
%            FIND_OFFSET, SIGNAL_PARALLEL.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.2.1



close all;

% Initialize arguments
switch(nargin)
    case 1
        elem = plot_data;
    case 0
        elem = 1;
end


% Import signals
[
    data_I, data_Q, data_xk_re, data_xk_im, data_Y_re, data_Y_im, ...
    data_sn_re, data_sn_im, data_out...
] = signals_parallel();
DATA_NUMBER = 20; 

QAM_MAPPING_OFFSET = 1;
I     = data_I((QAM_MAPPING_OFFSET:QAM_MAPPING_OFFSET+DATA_NUMBER-1),:);
Q     = data_Q((QAM_MAPPING_OFFSET:QAM_MAPPING_OFFSET+DATA_NUMBER-1),:);

FFT_OFFSET = min(find_offset(data_xk_re),find_offset(data_xk_im));
xk_re = data_xk_re((FFT_OFFSET:FFT_OFFSET+DATA_NUMBER-1),:);
xk_im = data_xk_im((FFT_OFFSET:FFT_OFFSET+DATA_NUMBER-1),:);

FILTER_OFFSET = min(find_offset(data_Y_re),find_offset(data_Y_im));
Y_re = data_Y_re((FILTER_OFFSET:FILTER_OFFSET+DATA_NUMBER-1),:);
Y_im = data_Y_im((FILTER_OFFSET:FILTER_OFFSET+DATA_NUMBER-1),:);

IFFT_OFFSET = min(find_offset(data_sn_re),find_offset(data_sn_im));
sn_re = data_sn_re((IFFT_OFFSET:IFFT_OFFSET+DATA_NUMBER-1),:);
sn_im = data_sn_im((IFFT_OFFSET:IFFT_OFFSET+DATA_NUMBER-1),:);

MOD_OFFSET = find_offset(data_out);
out   = data_out((MOD_OFFSET:MOD_OFFSET+DATA_NUMBER-1),:);



% QAM mapping
[I,Q] = QAM_mapper(I,Q,elem);

% FFT
[xk_re_th, xk_im_th] = DFT(I,Q,xk_re,xk_im,elem);

% Filter
[Y_re_th, Y_im_th] = SRRC_filter(xk_re,xk_im,Y_re,Y_im,elem);

% IFFT
[sn_re_th, sn_im_th] = IDFT(Y_re,Y_im,sn_re,sn_im,elem);

% Modulator
[out_th] = modulator(sn_re,sn_im,out,elem);

% Transmitter
[out_model] = transmitter(I,Q,out,elem);



% Output Results
exp_data = [...
    I Q xk_re xk_im Y_re Y_im sn_re sn_im out ...
];
MATLAB_data     = [...
    I Q xk_re_th xk_im_th Y_re_th Y_im_th sn_re_th sn_im_th out_th ...
];
 

end

function offset = find_offset(x)
% FIND OFFSET determine the offset introduced by hardware latency.
%           
%   See also TRANSMITTER.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



% Initialize variable
offset = size(x,1);

% Determin offset
for i=1:size(x,2)
    for j=1:size(x,i)
        if(x(j,1) ~= 0)
            offset = min(offset,j);
            return;
        end
    end
end

end