function res = Manhattan(x1,x2)
    
    res = 0
    for i=1:length(x1)
        res = res + abs(x1(i) - x2(i));
    end

end