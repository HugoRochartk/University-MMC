function y=metEuler_sistemas(f,a,b,alfa,N)
%METEULER_SISTEMAS Calcula solu��o de um sistema pelo m�todo de Euler
%
% Y=METEULER_SISTEMAS(F,A,B,ALFA,N)
% calcula aproxima��es para a solu��o de um sistema de m equa��es de 1a
% ordem Y'=F(X,Y), Y(A)=ALFA, usando o m�todo de Euler
%
% PAR�METROS DE ENTRADA:
% F: uma fun��o cujo resultado � um vetor coluna (mx1) correspondente a F(X,Y);
% A,B: reais, com A<B (extremos do intervalo onde se procura solu��o);
% ALFA: vetor linha (1xm) real, valor inicial da solu��o do sistema
% N: n�mero inteiro positivo (numero de subintervalos).
%
% PARAMETRO DE SAIDA:
% Y: matriz cujas m colunas cont�m valores aproximados da solu��o nos pontos
% X_K=A+KH; H=(B-A)/N ; K=1,...,N+1,
% obtidos usando o m�todo de Euler.
%
%Exemplo:
%
% alfa=[1 -1];
% f=@(x,y)) [y(1);3*y(1)-2*y(2)+6*exp(3*x)]
% metEuler_sistemas(f,0,1,alfa,10)
%---------------------------------------------------------------------
% VERIFICA��ES SOBRE PAR�METROS DE ENTRADA
%---------------------------------------------------------------------
% Verificar se N � inteiro e se A<B
if (length(N)~=1) || (fix(N) ~= N) || (N < 1)
error('N deve ser inteiro positivo');
elseif (a>=b)
error('a deve ser menor que b')
end
%---------------------------------------------------------------------
% DETERMINA��O DE H E CRIA��O DE VETOR DOS X_K
%---------------------------------------------------------------------
h=(b-a)/N;
x=a:h:b;
%---------------------------------------------------------------------
% M�TODO DE EULER
%---------------------------------------------------------------------
m=size(alfa,2);
y=zeros(N+1,m); % Inicializa��o da matriz solu��o.
y(1,:)=alfa; % Primeira coluna de y � o valor inicial ALFA.
for k=1:N
y(k+1,:)=y(k,:)+h*f(x(k),y(k,:))';
end
