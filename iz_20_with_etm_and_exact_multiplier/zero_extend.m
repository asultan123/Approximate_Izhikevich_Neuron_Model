function [ res ] = zero_extend( num, msb_pos, final_length )
    
    zero_extend = 0*ones(1,final_length-msb_pos-1);
    res = [zero_extend, num];
    
end

