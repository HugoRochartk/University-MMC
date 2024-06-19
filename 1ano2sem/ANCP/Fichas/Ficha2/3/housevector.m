function [v, v_Householder] = housevector(x)
    n = length(x);
    sigma = x(2:n)' * x(2:n);
    v = x;
    if sigma ~= 0
        miu = sqrt(x(1)^2 + sigma);
        if x(1) <= 0
            v(1) = x(1) - miu;
        else
            v(1) = (-sigma) / (x(1) + miu); 
        end
    end
    v_Householder = v / sqrt(v' * v);
end
