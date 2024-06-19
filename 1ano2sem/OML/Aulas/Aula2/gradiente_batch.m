function [ Grad ] = gradiente_batch(w,Xt,Yt)
% vetor gradiente de E  

I=length(w)-1;  %grau do polinomio;
nt=length(Xt);
Grad=zeros(I+1,1); % inicializar o vector gradiente como sendo o vector nulo

for i=1:nt
    Grad=Grad + (funphi(w,Xt(i),I)-Yt(i))*power(Xt(i),0:I)';
end
Grad=2*Grad/nt;
end

