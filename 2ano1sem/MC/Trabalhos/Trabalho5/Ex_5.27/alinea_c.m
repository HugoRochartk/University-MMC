% Exercício 5.27. alínea c)


% Na alínea c), podemos concluir que, à medida que o valor de delta diminui,
% o número de pontos usados pelas funções ode45 e ode23s aumenta. 
% Isso indica que a solução da equação diferencial apresenta variações mais 
% rápidas para valores de delta menores, exigindo uma maior quantidade de 
% pontos para manter a precisão.
% Esse comportamento sugere que, com valores menores de delta 
% a solução torna-se mais rígida, possivelmente devido à presença de regiões 
% de variação rápida. 
% A função ode45, precisa de muitos mais pontos para capturar essas variações
% enquanto ode23s, sendo mais indicado para problemas rígidos, consegue 
% resolver o problema com menos pontos.
% Portanto, podemos concluir que o problema se torna mais rígido para valores
% menores de delta, tornando métodos como ode23s mais eficientes do que 
% métodos como ode45.