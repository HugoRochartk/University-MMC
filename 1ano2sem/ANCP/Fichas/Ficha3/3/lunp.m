function [L, U] = lunp(A)

    n = size(A,1);
    U = A;
    L = eye(n);

    for j=1:n
        for i=j+1:n
            L(i,j) = U(i,j)/U(j,j);
            U(i,j:n) = U(i, j:n) - L(i,j)*U(j, j:n);
        end
    end
end

