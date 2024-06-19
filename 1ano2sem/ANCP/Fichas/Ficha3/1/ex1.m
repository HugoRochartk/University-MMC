%Definir matriz A
A = [1 0 1;
     1 1 1;
     0 0 1;
     1 1 1;
     0 1 1;
     1 1 0];

[m, n] = size(A);
%Definir valores das 3 normas necessárias
norma_1 = norm(A,1);
norma_2 = norm(A,2);
norma_inf = norm(A, inf);


%Primeira inequação
logical_val = (1/sqrt(n))*norma_inf <= norma_2 <= sqrt(m)*norma_inf;
r = "False";
if logical_val == 1
    r = "True";
end
fprintf("\nPrimeira inequação: (1/sqrt(n))*norma_inf <= norma_2 <= sqrt(m)*norma_inf:\n %.4f <= %.4f <= %.4f:\n %s\n", (1/sqrt(n))*norma_inf, norma_2, sqrt(m)*norma_inf, r)


%Segunda inequação
logical_val = (1/sqrt(m))*norma_1 <= norma_2 <= sqrt(n)*norma_1;
r = "False";
if logical_val == 1
    r = "True";
end
fprintf("\nSegunda inequação: (1/sqrt(m))*norma_1 <= norma_2 <= sqrt(n)*norma_1:\n %.4f <= %.4f <= %.4f:\n %s\n", (1/sqrt(m))*norma_1, norma_2, sqrt(n)*norma_1, r)