function [yk, lambda_k] = potinverso(A, p)  
    k = 0;
    n = size(A, 1);
    I = eye(n);
    
    A2 = A - p * I;
    
    [L, U] = lu(A2);

    y0 = L*ones(n, 1);
    
    yk = y0;
    lambda_k = 0;
    
    while k < 2
        k = k + 1;
        
        y_tilde = L \ yk;
        y_tilde = U \ y_tilde;
        
        [~, max_index] = max(abs(y_tilde));
        lambda_k = y_tilde(max_index)

        yk = y_tilde / lambda_k
    end
    
    lambda_k = 1 / lambda_k + p
end