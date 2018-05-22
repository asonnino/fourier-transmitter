function data = signals(input, separator)
% SIGNALS loads signals.
%
% Example:
%   data = signals('FQM_data_dec.txt') loads x all signals in the file
%   called FQM_data_dec.txt.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



% Initialize defaults parameters
filename  = 'FQM_simple_data_dec.txt';
delimiter = ',';

% Update parameters
switch(nargin)
    case 2
        filename  = input;
        delimiter = separator;
    case 1
        filename = input;
end

% Import
data = importdata(filename,delimiter);
    
end