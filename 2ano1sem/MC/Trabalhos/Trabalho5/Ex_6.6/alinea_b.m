% Exercício 6.6. alínea b)

%Lambda
lambda = 1;

%Equação diferencial ordinária
bratuEDO = @(x, y) [y(2); -lambda * exp(y(1))];

%Condições de fronteira
bratuFronteira = @(ya, yb) [ya(1); yb(1)];

%Aproximações iniciais
aproxs_ini = {
    @(x) [0.1; 0],         %Aproximação inicial alínea a)
    @(x) [3; 0],           %Aproximação inicial alínea b)
    @(x) [1*x.*(1-x); 1*(1-2*x)],  %Aproximação inicial alínea c) k=1
    @(x) [5*x.*(1-x); 5*(1-2*x)],  %Aproximação inicial alínea c) k=5
    @(x) [20*x.*(1-x); 20*(1-2*x)], %Aproximação inicial alínea c) k=20
    @(x) [30*x.*(1-x); 30*(1-2*x)] %Aproximação inicial alínea c) k=30
};

xmesh = linspace(0,1,10);
xplot = linspace(0,1,100);

figure; 
hold on;
colors = {'b', 'r', 'g', 'm', 'k', 'c'};
legends = {};


for i = 1:length(aproxs_ini)
    solinit = bvpinit(xmesh, aproxs_ini{i});
    sol = bvp4c(bratuEDO, bratuFronteira, solinit);
    y = deval(sol, xplot);
    
    plot(xplot, y(1,:), colors{i}, 'LineWidth', 2);
    legends{end+1} = sprintf('Aprox. %d', i);
end

xlabel('x'); ylabel('y(x)');
title('Soluções da Equação de Bratu');
legend(legends);
grid on;


% Como evidenciado no enunciado, a equação de Bratu admite duas soluções 
% distintas. No entanto, a convergência para uma dessas soluções depende 
% fortemente da aproximação inicial utilizada no método numérico. Ao
% analisar o gráfico das soluções obtidas, observa-se que as aproximações 
% 2, 5 e 6 convergiram para uma das soluções, enquanto as restantes 
% aproximações foram atraídas para a outra solução. Isso evidencia a 
% sensibilidade da equação de Bratu às condições iniciais como seria de 
% expectar com o gráfico.
