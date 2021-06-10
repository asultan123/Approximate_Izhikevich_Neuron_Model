function [ sum ] = INT_ADD( operand1, operand2 , ni)
    integer_part = (floor(operand1));
    sum = fi(integer_part.data + operand2,1,ni+operand1.FractionLength,...
        operand1.FractionLength);
    fraction_part = operand1 - floor(operand1);
    sum.bin(end-operand1.FractionLength+1:end) = ...
        fraction_part.bin(end-operand1.FractionLength+1:end);
end



