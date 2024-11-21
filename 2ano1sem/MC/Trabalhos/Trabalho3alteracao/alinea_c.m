% Definir função do integral
f = @(x) 1 ./ (1 + 25 * (x.^2));


% Cálculo do integral através da função definida regSimpsonAdapt
[int_Aprox, pontos] = regSimpsonAdapt(f, -1, 1, 10^-4, []);

% Abcissas
x_values = unique(pontos);

% Ordenadas
y_values = arrayfun(f, x_values);

% Gráfico
x_plot = linspace(-1, 1, 1000);
plot(x_plot, f(x_plot), 'b'); % Plot da função
xlabel('x');
ylabel('f(x)');
hold on;
scatter(x_values, y_values, 'r', 'filled'); % Pontos
title('Gráfico de f(x) = 1/(1+25x^2) juntamente com pontos usados para cálculo do integral');
legend('f(x) = 1/(1+25x^2)', 'Pontos usados para cálculo do integral');

