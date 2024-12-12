function y=metEuler_sistemas(f,a,b,alfa,N)
%METEULER_SISTEMAS Calcula solução de um sistema pelo método de Euler
%
% Y=METEULER_SISTEMAS(F,A,B,ALFA,N)
% calcula aproximações para a solução de um sistema de m equações de 1a
% ordem Y'=F(X,Y), Y(A)=ALFA, usando o método de Euler
%
% PARÂMETROS DE ENTRADA:
% F: uma função cujo resultado é um vetor coluna (mx1) correspondente a F(X,Y);
% A,B: reais, com A<B (extremos do intervalo onde se procura solução);
% ALFA: vetor linha (1xm) real, valor inicial da solução do sistema
% N: número inteiro positivo (numero de subintervalos).
%
% PARAMETRO DE SAIDA:
% Y: matriz cujas m colunas contêm valores aproximados da solução nos pontos
% X_K=A+KH; H=(B-A)/N ; K=1,...,N+1,
% obtidos usando o método de Euler.
%
%Exemplo:
%
% alfa=[1 -1];
% f=@(x,y)) [y(1);3*y(1)-2*y(2)+6*exp(3*x)]
% metEuler_sistemas(f,0,1,alfa,10)
%---------------------------------------------------------------------
% VERIFICAÇÕES SOBRE PARÂMETROS DE ENTRADA
%---------------------------------------------------------------------
% Verificar se N é inteiro e se A<B
if (length(N)~=1) || (fix(N) ~= N) || (N < 1)
error('N deve ser inteiro positivo');
elseif (a>=b)
error('a deve ser menor que b')
end
%---------------------------------------------------------------------
% DETERMINAÇÃO DE H E CRIAÇÃO DE VETOR DOS X_K
%---------------------------------------------------------------------
h=(b-a)/N;
x=a:h:b;
%---------------------------------------------------------------------
% MÉTODO DE EULER
%---------------------------------------------------------------------
m=size(alfa,2);
y=zeros(N+1,m); % Inicialização da matriz solução.
y(1,:)=alfa; % Primeira coluna de y é o valor inicial ALFA.
for k=1:N
y(k+1,:)=y(k,:)+h*f(x(k),y(k,:))';
end
