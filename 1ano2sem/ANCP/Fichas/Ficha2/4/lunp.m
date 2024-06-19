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

% para correr a função faz-se 
% A = [
%  [ 1 1 1 4 ]
%  [ 1 2 4 5 ]
%  [ 1 3 9 2 ]
%  [ 1 5 1 2 ]
% ]
%
% [L, U] = lunp(A)

% O output obtido é o seguinte:
%
% L = 
%   1 0 0  0
%   1 1 0  0
%   1 2 1  0
%   1 4 -6 1

% U = 
%   1 1 1  4
%   0 1 3  1
%   0 0 2 -4
%   0 0 0 -30


