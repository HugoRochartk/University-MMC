    clear;
    clc;
    close all
    %ler o data set 
    Data=csvread('ex1data1.csv');
    %Data=csvread('ex1data2.csv');
   
    [N, M]=size(Data); 
    Xdata=Data(:,1:M-1);  
    Ydata=Data(:,M);       
    I=M-1;  %numero de componentes de cada xn
     %---------- gráfico  de todo o data set 
    figure(1);
    In=find(Ydata==-1);
    Ip=find(Ydata==1);
    plot(Xdata(In,1),Xdata(In,2),'r.','MarkerSize',15)
    hold on
    plot(Xdata(Ip,1),Xdata(Ip,2),'b.','MarkerSize',15);
    hold on
    legend({'-1: data set ','+1: data set '});
    title('data set ');
    axis equal
    hold off 

    %----------
    %pause
    
    
    
    op=2;   %Data de treino 80% do data set:  op=1   seleciona a partir do inicio 80%; op=2  selecionado aleatoriamente 80%;
    Nt=round(0.8*N);
    if op==1
        p=1:N;
    end
    if op==2  %Data de treino - 80% do Data set -- selecionado aleatoriamente
        p = randperm(N); %returns a row vector containing a random permutation of the integers from 1 to M inclusive
    end
   
    
    Xt=Xdata(p(1:Nt),:);   
    Yt=Ydata(p(1:Nt),:);  
    
    %Data set para validação - 20% do Data set-- selecionado aleatoriamente 
     Xv=Xdata(p(Nt+1:N),:);
     Yv=Ydata(p(Nt+1:N),:);
    
     
    
    X=Xt';   % Pontos -- organiza-los por coluna: X1; X2; ...;XN
    Y=Yt';   % labels correspondentes -- vetor linha: Y1,Y1,...,Y2
 
    %------------ resolver o problema quadrático dual (slides SVM page 19) --- 
    options = optimoptions('quadprog','Display','iter');
   
   
    Q=(Y'*Y).*(X'*X);           % compute the quadratic matrix
    c=-ones(Nt,1);              % coefficients of linear term
    Aeq=Y;                      % coefficient matrix --> we only have one linear constraint 
    beq=0;                      % constants of linear equality constraints  
    lb = zeros(Nt,1);
    
    alpha=0.1*ones(Nt,1);       % initial guess of solution

   % solve the quadratic problem  to find alphas by interior-point method
   [alpha,fval,exitflag,output]=quadprog(Q,c,[],[],Aeq,beq,lb,[],alpha,options); 
    
   %---- fim da resolução do problema ----
   
    Index=find(abs(alpha)>10^(-3));   % indices of non-zero alphas
    asv=alpha(Index)';                % non-zero alphas
    Xsv=X(:,Index);                   % support vectors
    ysv=Y(:,Index);                   % their labels
    w=sum(repmat(ysv.*asv,I,1).*Xsv,2);  % normal vector (not needed)
  % bias=mean(ysv-w'*Xsv);               % bias corresponde ao w0 
    %-- outro modo de programar o calculo do bias 
     Ksv=Xsv'*Xsv;
     bias=mean(ysv-(ysv.*asv)*Ksv);  %bias é w0
    %--- 
    fprintf('SVM - Vetores de suporte: \n');
    fprintf('  n:    alpha_n         Xsv                   Y_n   \n');
    for j=1:length(Index)
       fprintf('%4i    %.4f      x=[%.4f, %.4f]     %4d \n', Index(j), asv(j), Xsv(1,j), Xsv(2,j), ysv(j)); 
      
    end
    %pause
    fprintf('\n\n SVM-parametros ótimos do hiperplano:\n')
    w0=bias,  w=w 
    %pause
    %---- gráfico  do data set de treino 
    In=find(Yt==-1);
    Ip=find(Yt==1);
    figure 
    h(1)=plot(Xt(In,1),Xt(In,2),'r.','Markersize',15);
    hold on;
    h(2)=plot(Xt(Ip,1),Xt(Ip,2),'b.','MarkerSize',15);
    hold on
   
    %-- gráfico dos support vectors
    h(3)=plot(X(1,Index),X(2,Index),'ko','Markersize',8);
    hold on
     %---- opcional
    flag=0;  % flag=1 faz também o gráfico do  data set de validação; flag=0  não faz o gráfico do  data set de validação
    if flag
        In=find(Yv==-1);
        Ip=find(Yv==1);
        h(5)=plot(Xv(In,1),Xv(In,2),'ro','Markersize',4);
        hold on
        h(6)=plot(Xv(Ip,1),Xv(Ip,2),'bo','MarkerSize',4);
        hold on
    end
    
    %--- gráfico do Hiperplano: fronteira de decisão
    d = 0.02;
    x1=min(Xt(:,1)):d:max(Xt(:,1));
    x2=-w0/w(2)-(w(1)/w(2)).*x1;
    h(4)=plot(x1,x2,'k','LineWidth',2);
   
    %----
    title('SVM dual ');
    if ~flag
       legend(h,{'-1: data set treino','+1: data set treino','Support Vectors', 'Hiperplano'});    
    else  
       legend(h,{'-1: data set treino','+1: data set treino','Support Vectors', 'Hiperplano', '-1: data set validação','+1: data set validação'});
        
    end
    axis equal
    hold off
    %----------
    %classificador 
    % Avaliar o erro com o data set de validação Xv, Yv
    
    Yp=Classificador(w0,w,Xv');  % Yp - classe prevista pelo classificador
    ErrDv=sum(abs(Yp-Yv));  % out-sample error == erro com o data de validação
    
   fprintf('\n out-sample error: %.4e ', ErrDv);
    
    
    
    
    
    