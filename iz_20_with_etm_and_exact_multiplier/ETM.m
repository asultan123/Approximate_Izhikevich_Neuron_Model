function [ result ] = ETM( operand1, operand2, upper_bit_count,integer_precision,fraction_precision )

    ni = integer_precision;     %integer length
    nf = fraction_precision;    %fractional length

    %   segment operands into upper and lower bits
    operand1 = fi(operand1,1,ni+nf,nf);
    operand1_upper_bits = fi(0,1,upper_bit_count,0);
    operand1_lower_bits = fi(0,0,ni+nf-upper_bit_count,0);

    operand2 = fi(operand2,1,ni+nf,nf);
    operand2_upper_bits = fi(0,1,upper_bit_count,0);
    operand2_lower_bits = fi(0,0,ni+nf-upper_bit_count,0);

    operand1_upper_bits.bin = operand1.bin(1:upper_bit_count);
    operand1_lower_bits.bin = operand1.bin(upper_bit_count+1:length(operand1.bin));

    operand2_upper_bits.bin = operand2.bin(1:upper_bit_count);
    operand2_lower_bits.bin = operand2.bin(upper_bit_count+1:length(operand2.bin));

    
    %   evaluate upper bits
    result_upper_bits_multiplication = operand1_upper_bits*operand2_upper_bits;

    %   evaluate lower bits
    result_lower_bits_multiplication = fi(0,0,2*(ni+nf-upper_bit_count),0);
    temp = bitor(operand1_lower_bits,operand2_lower_bits);
    
    ones_index = strfind(temp.bin,'1');

    if size(ones_index,1) ~= 0
        for i = ones_index(1):length(result_lower_bits_multiplication.bin)
            result_lower_bits_multiplication.bin(i) = '1';
        end
    end

    etm_result = fi(0,1,2*(ni+nf),2*nf);

    etm_result.bin = strcat(result_upper_bits_multiplication.bin,result_lower_bits_multiplication.bin);
    
    result = etm_result;
    
end



