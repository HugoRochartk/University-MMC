% Exercício 5.27. alínea a)

%Equação Diferencial Ordinária
EDO = @(x, y) y^2 - y^3;

%Condições
delta = 0.1;
span = [0, 2/delta];
y0 = delta;

%Solução ode45
[x_ode45, y_ode45] = ode45(EDO, span, y0);

%Solução ode23s
[x_ode23s, y_ode23s] = ode23s(EDO, span, y0);


figure;

%Gráfico ode45
subplot(2, 1, 1); 
plot(x_ode45, y_ode45, 'b-');
title('Solução ode45 (\delta = 0.1)');
xlabel('x');
ylabel('y');

%Gráfico ode23s
subplot(2, 1, 2); 
plot(x_ode23s, y_ode23s, 'r-');
title('Solução ode23s (\delta = 0.1)');
xlabel('x');
ylabel('y');

%Número de pontos usados
fprintf('Pontos ode45: %d\n', length(x_ode45));
fprintf('Pontos ode23s: %d\n', length(x_ode23s));

%NOTA: Correr para ver os gráficos

%OUTPUT:

%Pontos ode45: 45
%Pontos ode23s: 21


