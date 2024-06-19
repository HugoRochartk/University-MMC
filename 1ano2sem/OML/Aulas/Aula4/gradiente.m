function [ GradE ] = gradiente(w,X,Y)
% vetor gradiente de E  

I=length(w)-1;  %grau do polinomio;
n=length(X);
GradE=zeros(I+1,1); % inicializar o vector gradiente como sendo o vector nulo

for i=1:n
    GradE=GradE + (funphi(w,X(i),I)-Y(i))*power(X(i),0:I)';
end
GradE=GradE/n;
end

