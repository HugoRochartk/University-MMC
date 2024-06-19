%a
A = [10 -3 6; -3 3 -2; 6 -2 1];
y0 = [1; 0; 0];  
max_iter = 5; %determinamos por tentativa que bastavam 4 iterações

[lambda, yk] = met_potencia(A, y0, max_iter);

%b
lambda_rayleigh = (yk' * A * yk) / (yk' * yk) 

%c
B=inv(A-1.89*eye(3))

[V, D] = eig(B)

[lambda, yk] = met_potencia(B, y0, max_iter);

%d
[L, U] = lu(A - 1.89 * eye(3))
%usando a função das aulas
[L, U] = lunp(A - 1.89 * eye(3))

%e
y0 = [0.32; 0.94; 0.03]; 
p=1.89;
[yk, lambda_k] = potinverso(A, p);



