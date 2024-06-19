%Exercicio 1


A = [1 1; 2 3; 0 1];
b = [0; 5; 1];

% a)
x = inv(A'*A)*A'*b;
norm(A*x - b);


% b)
x = (A'*A)\(A'*b);
norm(A*x - b);


% c)
[Q,R] = cgs(A); %fazer com mgs
c = Q'*b;
x = R\c;
norm(A*x - b)



%FALTA EX. 2 STORA NAO FEZ

%comandos: help polyval (ajuda sobre 1 comando) | format long (mostrar mais
%digitos) | vander(V) (dado vetor v constroi matriz de vandermonde) 