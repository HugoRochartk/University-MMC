function [L, U] = fact_UL(A)

    [m, n] = size(A);
    U = A;
    L = eye(n);

    for j=n:-1:1
        for i=(j-1):-1:1
            L(i,j) = U(i,j)/U(j,j);
            U(i,j:-1:1) = U(i, j:-1:1) - L(i,j)*U(j, j:-1:1);
        end
    end
end

% L é triangular superior com 1's na diagonal (novo U)
% U é triangular inferior (novo L)
% No ficheiro de teste, fazendo U*L obtém-se a matriz original A
