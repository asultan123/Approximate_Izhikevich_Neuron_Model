function [ result ] = ETS( operand, squaring_circuit,integer_precision,fraction_precision )

    ni = integer_precision;     %integer length
    nf = fraction_precision;    %fractional length
    upper_bit_count = 8;

    
    %   segment operands into upper and lower bits
    operand1 = fi(operand,0,ni+nf,nf,'OverflowAction','Wrap');
    
%       get absolute value (minus 1)
    if(operand1.bin(1)=='1')
        for i = 1:length(operand1.bin)
            if(operand1.bin(i)=='1')
                operand1.bin(i) = '0';
            else
                operand1.bin(i) = '1';
            end
        end
    end
    
    operand1_upper_bits = fi(0,0,upper_bit_count,0);
    operand1_lower_bits = fi(0,0,ni+nf-upper_bit_count,0);

    operand1_upper_bits.bin = operand1.bin(1:upper_bit_count);
    operand1_lower_bits.bin = operand1.bin(upper_bit_count+1:length(operand1.bin));
    
    %   evaluate upper bits
    result_upper_bits_multiplication = fi(step(squaring_circuit,operand1_upper_bits),0,ni*2,0);
%     result_upper_bits_multiplication = operand1_upper_bits*operand1_upper_bits;

    %   evaluate lower bits
    result_lower_bits_multiplication = fi(0,0,2*(ni+nf-upper_bit_count),0);
    
    ones_index = strfind(operand1_lower_bits.bin,'1');

    if size(ones_index,1) ~= 0
        for i = ones_index(1):length(result_lower_bits_multiplication.bin)
            result_lower_bits_multiplication.bin(i) = '1';
        end
    end

    etm_result = fi(0,0,2*(ni+nf),2*nf);

    etm_result.bin = strcat(result_upper_bits_multiplication.bin,result_lower_bits_multiplication.bin);
    
    result = etm_result;
    
end



