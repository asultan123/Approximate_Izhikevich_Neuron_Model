function [ pattern ] = getPattern( input )
    
    lastIndex = find(input==-2000);
    if(size(lastIndex,2) ~= 0)
        lastIndex = lastIndex(1) - 1;
    else
        lastIndex = size(input,2);
    end
    
    pattern = input(1:lastIndex);

end

