function [lambda, yk] = met_potencia(A, y0, max_iter)

    k = 0;
    yk = y0;
    
    while k < max_iter
        k = k + 1;
        y_tilde = A * yk         
        lambda = max(abs(y_tilde))
        yk = y_tilde / lambda   
    end
end

