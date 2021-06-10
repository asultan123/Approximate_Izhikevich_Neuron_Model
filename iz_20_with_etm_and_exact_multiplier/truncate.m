function [ output ] = truncate( input, ni, nf , fimath_object)
    
    input_worldlength = input.WordLength;
    input_fractionlength = input.FractionLength;
    input_integerlength = input_worldlength - input_fractionlength;
    input_binary = input.bin;
    
    output = fi(0,1,ni+nf,nf, fimath_object);
    output.bin = input_binary(input_integerlength-ni+1:end-input_fractionlength+nf);
%     
%     for i = 1:length(output.bin)
%         if output.bin(i) == '0'
%             return
%         end
%     end
%     
%     output = fi(0,1,ni+nf,nf, fimath_object);
%     
end

