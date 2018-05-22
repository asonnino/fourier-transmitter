function [out_model] = transmitter(I,Q,out,plot_data)
% TRANSMITTER Plot the experimental result and the computed theoretical  
%             output of the select inpur set of the transmitter block. 
%           
%   See also QAM_MAPPING, DFT, SRRC_FILTER, IDFT, MODULATOR, PLOT_COMP,
%            PLOT_SINGLE.
%
% AUTHOR  Sonnino Alberto.
% VERSION 1.0.1



% Check argument's size
sizeCheck =( size(I) == size(Q) ) & ( size(I) == size(out) );
if( ~(sizeCheck(1,1) && sizeCheck(1,2)) )
    display('Error - TRANSMITTER: wrong arguments size');
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
[tmp1, tmp2] = QAM_mapper(I,Q,0);
[tmp1, tmp2] = DFT(tmp1,tmp2,tmp1,tmp1,0);
[tmp1, tmp2] = SRRC_filter(tmp1,tmp2,tmp1,tmp1,0);
[tmp1, tmp2] = IDFT(tmp1,tmp2,tmp1,tmp1,0);
out_model    = modulator(tmp1,tmp2,out,0); 


% Plot
if((elem <= size(I,1)) && (elem > 0))
    % Plot out and out_model
    plot_comp(out(elem,:),out_model(elem,:),'Data','MATLAB','Transmitter Output');
    
    % Plot the error between xk_re and xk_re_th
    plot_single(abs(out(elem,:)-out_model(elem,:)),'Transmitter Output Error','error');

end

end