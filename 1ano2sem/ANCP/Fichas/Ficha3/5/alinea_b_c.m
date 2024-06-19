A = hilb(4); %A simétrica
[Q,T] = hess(A);
[n, n] = size(A);


while n > 1
        
    while abs(T(n, n-1)) > 10^(-6)
        I = eye(n);
        pk = T(n,n);
        [Q,R] = qrhouseholder(T - pk*I);
        T = R*Q + pk*I;
    end
    
    myEigValues(n) = T(n,n);
    T = T(1:(n-1), 1:(n-1)); 
    n = n-1;
    
end
    
myEigValues(1) = T(1,1);



%Exemplo com a matriz de Hilbert A de ordem 4
%Comparar com os valores próprios calculados pela função do Matlab (iguais)
matlabEigValues = eig(A);
myEigValues, matlabEigValues







