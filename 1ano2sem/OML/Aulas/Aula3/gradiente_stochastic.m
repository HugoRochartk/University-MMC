function [ GradE ] = gradiente_stochastic(w,Xt,Yt)
% vetor gradiente de E  

I=length(w)-1;  %grau do polinomio;
nt=length(Xt);
GradE=zeros(I+1,1); % inicializar o vector gradiente como sendo o vector nulo

%gradiente estocástico
  i=randi(nt);  %escolhe aleatoriamente um indice na gama de 1:nt
  GradE=(funphi(w,Xt(i),I)-Yt(i))*power(Xt(i),0:I)';


end

