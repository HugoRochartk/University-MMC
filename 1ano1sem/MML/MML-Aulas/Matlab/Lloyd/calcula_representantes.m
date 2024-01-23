function [Mx_new,My_new]=calcula_representantes(P,x,N,K)

%percorre a lista da particao e quando o indice e 1 "cria" classe 1
%quando é 2 "cria" classe 2
%depois para cada classe calcula média das coordenadas 1 dos elementos
%da classe e coordenada 2 dos elementos da classe

%retorna coordenadas x dos representantes em Mx_new e de y em My_new
%inicializacoes

for i=1:K
  number(i)=0;%numero de elementos da classe i
  mx(i)=0;% lista das primeiras coordenadas dos representantes
  my(i)=0;% lista das segundas coordenadas dos representantes
end

for i=1:K %para todos os clusters
  for j=1:N  %para todos os elementos da BD
    if P(j)==i
      mx(i)=mx(i)+x(j,1);  
      my(i)=my(i)+x(j,2); 
      number(i)=number(i)+1;
    end
  end
  mx(i)=mx(i)/number(i);
  my(i)=my(i)/number(i);
end
Mx_new=mx;
My_new=my;
end