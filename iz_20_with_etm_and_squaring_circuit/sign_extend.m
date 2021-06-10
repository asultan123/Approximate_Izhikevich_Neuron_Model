function [ output ] = sign_extend( input, ni, nf )

    input_worldlength = input.WordLength;
    input_fractionlength = input.FractionLength;
    input_integerlength = input_worldlength - input_fractionlength;
    input_binary = input.bin;
    input_start_point = ni-input_integerlength+1;
        
    output = fi(0,1,ni+nf,nf);

    output.bin(input_start_point:input_start_point-1+input_worldlength)...
            = input_binary;
        
    sign_bit = input_binary(1);
    
    if sign_bit == '1'
        
        for i = 1:ni-input_integerlength
            output.bin(i) = sign_bit;
        end
        
    end
 
            
end

