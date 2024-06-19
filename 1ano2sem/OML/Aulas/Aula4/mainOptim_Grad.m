
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
wk=[0;0] %ponto inicial
%---------
eta=0.001;  %com eta=0.01 dá NAN
gradk=subs(grad, [w1;w2], wk); %calcula o gradiente no ponto wk   
Fval=[];
while ( norm(gradk)> tol && k<=maxit)  % --  
    
    %calcular o gradiente no ponto wk
    gradk=double(subs(grad, [w1;w2], wk)); %calcula o gradiente completo no ponto wk   
    %calcular a direção procura de descida máxima  
    sk=-gradk; 
    
    %%%%
    Fk=double(subs(F, [w1;w2], wk));   %calcular a função objectivo no ponto wk
    Fval=[Fval Fk];
    %%%%%%%%%%%%%%%%%%%%%%%%%% etak
   
    %%%%%%%%%%%%%
    %calcular o novo ponto
    wk=wk+eta*sk
    k=k+1
    
    %----  para fazer o gráfico dos valores Ek da função objetivo MSE 
    
end

%--- escrever a solução:  a última a  sair do processo iterativo

fprintf('solução ótima w*:\n' );
fprintf(' %2.4e \n',wk); 
fprintf('valor ótima F(w*): %2.4e \n',Fk); 
 




%valor da função objectivo ao longo do processo iterativo
figure(1)
plot(Fval)

%

