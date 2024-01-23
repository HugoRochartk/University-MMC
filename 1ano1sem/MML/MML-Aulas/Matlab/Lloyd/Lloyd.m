%function lloyd()

% programa baseado no algoritmo de lloyd para fazer "clustering" duma BD
% eventos pertencem a R^2, lidos dum ficheiro BD.txt
% metrica usada  euclidiana -> representante do tipo
% centroide cujas componentes sao a média


clear all
clc


M = []; %array com dados
I = 2; %numero de componentes de um evento


f = fopen('BDteste.txt', 'r')
i = 1;
while ~feof(f)
    xx = fscanf(f, '%f %f\n', 2); %le cada linha
    for j=1:I
        x(i,j) = xx(j);
    end
    i = i+1;
end
fclose(f);
x
N=i-1;



%representacao dos dados 

figure(1)
for i=1:N
  plot(x(i,1),x(i,2),'r*');
  hold on
end



%N=length(x); %numero de eventos na BD
K=2; %numero de clusters
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % representantes - inicializacao

m1x=1;
m1y=1;
m2x=3;
m2y=3;
%assim obtem só um cluster
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Mx=[m1x m2x]; % tem conjunto de primeiras coordenadas dos representantes
My=[m1y m2y]; % tem conjunto de segundas coordenadas dos representantes
% 
% 
CP=1;
% 
it=0;
while CP>0.0001
 P=calcula_particao(Mx,My,x,K)% recebe array com N (num de eventos) com o label do cluster a que pertencem
 [Mx_new,My_new]=calcula_representantes(P,x,N,K);  %com metrica euclidiana -> media
 CP=diferenca_representantes(Mx,My,Mx_new,My_new,K); %metrica de distancia entre novos representantes e antigos
 Mx=Mx_new;
 My=My_new;
 it=it+1
end
% 
'RESULTADO:'
'*********************'

P
Mx
My

figure(2)
for i=1:length(P)
  if P(i)==1
   plot(x(i,1),x(i,2),'r*');
   hold on
  else
   plot(x(i,1),x(i,2),'k*');
   hold on
  end
end


