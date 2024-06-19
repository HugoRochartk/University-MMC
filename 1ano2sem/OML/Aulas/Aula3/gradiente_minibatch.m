function [ GradE ] = gradiente_minibatch(w,Xt,Yt)
% vetor gradiente de E  

I=length(w)-1;  %grau do polinomio;
nt=length(Xt);
GradE=zeros(I+1,1); % inicializar o vector gradiente como sendo o vector nulo
%gradiente mini-batch
 nb=round(0.05*nt);   %selecionar 5% do Dt
 p=randperm(nt,nb);    %gera aleatoriamente nb numeros inteiros do intervalo 1:nt
 for i=1:nb
    GradE=GradE + (funphi(w,Xt(p(i)),I)-Yt(p(i)))*power(Xt(p(i)),0:I)';
 end
 GradE=GradE/nb;
    
end



