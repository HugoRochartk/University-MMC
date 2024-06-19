
clc;
clear;

%exercicio1
syms w1 w2;

% fun��o de Rosenbrock

F=(1-w1)^2 + 100*(w2-w1^2)^2;

grad=[diff(F,w1); diff(F,w2)];


%-------
tol=1e-6;
maxit=1000;   
k=1;
wk=[0;0] %ponto inicial
%---------
eta=0.001;  %com eta=0.01 d� NAN
gradk=subs(grad, [w1;w2], wk); %calcula o gradiente no ponto wk   
Fval=[];
while ( norm(gradk)> tol && k<=maxit)  % --  
    
    %calcular o gradiente no ponto wk
    gradk=double(subs(grad, [w1;w2], wk)); %calcula o gradiente completo no ponto wk   
    %calcular a dire��o procura de descida m�xima  
    sk=-gradk; 
    
    %%%%
    Fk=double(subs(F, [w1;w2], wk));   %calcular a fun��o objectivo no ponto wk
    Fval=[Fval Fk];
    %%%%%%%%%%%%%%%%%%%%%%%%%% etak
   
    %%%%%%%%%%%%%
    %calcular o novo ponto
    wk=wk+eta*sk
    k=k+1
    
    %----  para fazer o gr�fico dos valores Ek da fun��o objetivo MSE 
    
end

%--- escrever a solu��o:  a �ltima a  sair do processo iterativo

fprintf('solu��o �tima w*:\n' );
fprintf(' %2.4e \n',wk); 
fprintf('valor �tima F(w*): %2.4e \n',Fk); 
 




%valor da fun��o objectivo ao longo do processo iterativo
figure(1)
plot(Fval)

%

