function [...
    data_I, data_Q, data_xk_re, data_xk_im, data_Y_re, data_Y_im,...
    data_sn_re, data_sn_im, data_out ...
] = signals_parallel(...
    input_I, input_Q, input_xk_re, input_xk_im, input_Y_re, input_Y_im, ...
    input_sn_re, input_sn_im, input_out,...
    separator...
)
% SIGNALS_PARALLEL loads signals.
%
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.2.0



% Initialize parameters
switch(nargin)
    case 10
        filename_I  = input_I;
        filename_Q  = input_Q;
        filename_xk_re  = input_xk_re;
        filename_xk_im  = input_xk_im;
        filename_Y_re  = input_Y_re;
        filename_Y_im  = input_Y_im;
        filename_sn_re  = input_sn_re;
        filename_sn_im  = input_sn_im;
        filename_out  = input_out;
        delimiter = separator;
    case 1
        delimiter = separator;
    case 0
        filename_I  = 'FQM_parallel_data_dec_I.txt';
        filename_Q  = 'FQM_parallel_data_dec_Q.txt';
        filename_xk_re  = 'FQM_parallel_data_dec_xk_re.txt';
        filename_xk_im  = 'FQM_parallel_data_dec_xk_im.txt';
        filename_Y_re  = 'FQM_parallel_data_dec_Y_re.txt';
        filename_Y_im  = 'FQM_parallel_data_dec_Y_im.txt';
        filename_sn_re  = 'FQM_parallel_data_dec_sn_re.txt';
        filename_sn_im  = 'FQM_parallel_data_dec_sn_im.txt';
        filename_out  = 'FQM_parallel_data_dec_out.txt';
        delimiter = ',';
end

% Import
data_I = importdata(filename_I,delimiter);
data_Q = importdata(filename_Q,delimiter);
data_xk_re = importdata(filename_xk_re,delimiter);
data_xk_im = importdata(filename_xk_im,delimiter);
data_Y_re = importdata(filename_Y_re,delimiter);
data_Y_im = importdata(filename_Y_im,delimiter);
data_sn_re = importdata(filename_sn_re,delimiter);
data_sn_im = importdata(filename_sn_im,delimiter);
data_out = importdata(filename_out,delimiter);
    
end