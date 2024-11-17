% Função f
f = @(x) 1 ./ (1 + 25 * x.^2);

% Pela alínea b) percebemos que na chamada recursiva da função a função
% acabou por retornar N = 36 isto significa que foram usados 36
% subintervalos para ter uma aproximação cujo cálculo da estimativa para o
% erro (com ajuda do cálculo da estimativa para metade dos subintervalos
% (18)) não ultrapasse a tolerância tol.

% Intervalos e pontos para 36 subintervalos
x_values = linspace(-1, 1, 37);
y_values = f(x_values);

% Intervalos e pontos para metade dos subintervalos (18 subintervalos)
% usados para o cálculo da estimativa do erro
x_half_values = linspace(-1, 1, 19);
y_half_values = f(x_half_values);

% Gráfico
x_plot = linspace(-1, 1, 1000);
plot(x_plot, f(x_plot), 'b'); % Plot da função
xlabel('x');
ylabel('f(x)');
hold on;
scatter(x_values, y_values, 'r', 'filled'); % Pontos para 36 subintervalos a vermelho
scatter(x_half_values, y_half_values, 'g', 'filled'); % Pontos para 18 subintervalos a verde (também usados para os 36 subintervalos)
title('Gráfico de f(x) = 1/(1+25x^2) juntamente com pontos usados para cálculo do integral');
legend('f(x) = 1/(1+25x^2)', 'Pontos para 36 subintervalos', 'Pontos para 18 subintervalos');

