
clc;
clear;

%exercicio1
syms w1 w2;

% função de Rosenbrock

F=(1-w1)^2 + 100*(w2-w1^2)^2;

grad=[diff(F,w1); diff(F,w2)];


%-------
tol=1e-6;
maxit=1000;   
k=1;
wk=[0;0]; %ponto inicial
mk=[0;0];
sk=[0;0];
%parametros do Adam
beta1=0.9;
beta2=0.999;
epsilon=1e-8;
eta=0.01;  %com eta=0.001 não converge
%---------

gradk=subs(grad, [w1;w2], wk); %calcula o gradiente no ponto wk   
Fval=[];
while ( norm(gradk)> tol && k<=maxit)  % --  
    
    %calcular o gradiente no ponto wk
    gradk=double(subs(grad, [w1;w2], wk)); %calcula o gradiente completo no ponto wk   
    %atualizar mk, sk
    mk=beta1*mk+(1-beta1)*gradk;
    sk=beta2*sk+(1-beta2)*gradk.*gradk;
    
    %calcular
    m=mk/(1-beta1^k);
    s=sk/(1-beta2^k);
     
        
    %%%%
    Fk=subs(F, [w1;w2], wk);   %calcular a função objectivo no ponto wk
   
      
    %%%%%%%%%%%%%
    %calcular o novo ponto
    wk=wk-eta*m./(epsilon+sqrt(s));
    k=k+1
    
    %----  para fazer o gráfico dos valores da função objetivo
    Fval=[Fval,Fk];
    
    
end

%--- escrever a solução:  a última a  sair do processo iterativo
k
fprintf('solução ótima w*:\n' );
fprintf(' %2.4e \n',wk); 
fprintf('valor ótima F(w*): %2.4e \n',Fk); 
 




%valor da função objectivo ao longo do processo iterativo
figure(1)
plot(Fval)

%

