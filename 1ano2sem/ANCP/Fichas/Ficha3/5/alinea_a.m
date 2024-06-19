%Criar a matriz de Hilbert de ordem 4
A = hilb(4);

%Transformar a matriz A numa matriz tridiagonal ortogonalmente semelhante
[Q, T] = hess(A);

%Mostrar a matriz tridiagonal T ortogonalmente semelhante a A
T