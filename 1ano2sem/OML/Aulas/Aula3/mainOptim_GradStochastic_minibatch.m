
%ler o data set  data1.xlsx
Data=xlsread('data1.xlsx');
N=length(Data);
 
X=Data(:,1);
Y=Data(:,2);

%gráfico do data set 
figure (1)
plot(X,Y,'bo','Markersize',1);
hold on
xdata=(0:0.01:1)';
np=length(xdata);
%-----------------------------


%Data treino - 80% do Data -- selecionado aleatoriamente
p = randperm(N); %returns a row vector containing a random permutation of the integers from 1 to N inclusive.
nt=0.8*N;
Xt=Data(p(1:nt),1);
Yt=Data(p(1:nt),2);

%Data para validação - 20% do Data -- selecionado aleatoriamente 
Xv=Data(p(nt+1:N),1);
Yv=Data(p(nt+1:N),2);


%polinomio de grau I a ajustar
I=7;  %grau do polinómio I=2, I=3, I=4, I=5, I=6, I=7


% Calcular etak: taxa de aprendizagem (=comprimento do passo)
% ParamP=1 então etak é calculado usando o alg.  condição Armijo com backtracking; 
% ParamP=2 então etak é constante;
% ParamP=3 então etak reduz ao fim de uma época

paramP=1;    

%-------
tol=1e-4;
%---------
maxit=10*nt;  % época é nt 
k=1;
wk=zeros(I+1,1); %ponto inicial
%--
E=[];

nb=round(0.05*nt);   %selecionar 5% do dataset de treino 
while ( k<=maxit)  % -- no estocástico e mini-batch usar apenas número de iterações!!
    
    %gerar o mini-batch
    p=randperm(nt,nb);    %gera aleatoriamente nb numeros inteiros do intervalo 1:nt
    Xb=Xt(p(1:nb),1);
    Yb=Yt(p(1:nb),1);

    %calcular o vetor gradiente no ponto wk usando o mini-batch
         
    [gradk]=gradiente(wk,Xb,Yb);
    %calcular a direção de procura
    sk=-gradk; 
    
    %%%%
    Ek=funE(wk,Xb,Yb);  %calcular a função MSE no ponto wk usando o mini-batch
    %%%%%%%%%%%%%%%%%%%%%%%%%% etak
    %calcular etak, a taxa de aprendizagem/comprimento do passo
     
    if paramP==1  %alg. da condição Armijo com backtracking  
      etak = backtrackingArmijo(wk,Ek,gradk,sk, Xb,Yb);   % re-adaptada 
    end
    
    if paramP==2  %etak é constante
     etak=0.1;
    end
    
    if paramP==3 %etak reduz ao fim de uma época
     etak=0.1;
     if mod(k,nt)==0
         d=k/nt;
         etak=1/(10^d);  %min(1/10^d,1e-6)
     end
    end
    %%%%%%%%%%%%%55
    
    %calcular o novo ponto
    wk=wk+etak*sk;
    k=k+1;
    
    %----  para fazer o gráfico de Ek
    E=[E,Ek];
    %-- para fazer o gráfico do polinomio ao longo do processo iterativo
%     for i=1:np
%       ydata(i)=funphi(wk,xdata(i),I);  %calcula o polinomio no pto xdata(i)
%     end
%     plot(xdata,ydata,'.-m');
end



%--- escrever a solução
fprintf('solução ótima w*: \n'); 
wk %solução ótima: a última a  sair do processo iterativo

EDt=funE(wk,Xt,Yt);  % valor ótimo == in-sample error  (erro usando o data de treino)
fprintf('\n in-sample error E(wopt,Dt): %.12e ', EDt);


EDv=funE(wk,Xv,Yv);   % out-sample error == erro com o data de validação
fprintf('\n out-sample error E(wopt,Dv): %.12e', EDv);

%polinomio com os parâmetros ótimos 
for i=1:np
    ydata(i)=funphi(wk,xdata(i),I);  %calcula o polinomio no ponto xdata(i)
end


plot(xdata,ydata,'.-g');


hold off

%valor da funE (função objectivo/custo) ao longo do processo iterativo
figure(2)
plot(E)

%

