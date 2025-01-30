% Exercício 5.19. alíneas a) e b)

%Função do PVI
f = @(x, y) y - y/x;

%Parâmetros iniciais
x0 = 1;
y0 = 0.5;
h = 0.1;
N = 10;

%Solução aproximada
results = metPC4(f, x0, y0, h, N);

%Solução exata
exact_solution = @(x) exp(x - 1) ./ (2 .* x);  

%Tabela
fprintf('x_k         y_aprox     y_exato    erro\n');
for i = 1:size(results, 1)
    x_k = results(i, 1);
    y_aprox = results(i, 2);
    y_exato = exact_solution(x_k);
    erro = abs(y_aprox - y_exato);
    fprintf('%f    %f    %f   %e\n', x_k, y_aprox, y_exato, erro);
end


%Gerar pontos exatos para o gráfico da solução exata
x_values = linspace(1, 2, 100);
y_exact_values = exact_solution(x_values);

%Plot da solução exata
figure;
plot(x_values, y_exact_values, 'b', 'LineWidth', 2);
hold on;

%Plot dos resultados aproximados
plot(results(:, 1), results(:, 2), 'r', 'LineWidth', 2);

%Configurações
xlabel('x');
ylabel('y');
title('Solução exata e aproximada do PVI');
legend('Solução Exata', 'Solução Aproximada', 'Location', 'Best');
grid on;
hold off;

% OUTPUT:

% x_k         y_aprox     y_exato    erro
% 1.000000    0.500000    0.500000   0.000000e+00
% 1.100000    0.502350    0.502350   3.422459e-08
% 1.200000    0.508918    0.508918   5.663878e-08
% 1.300000    0.519176    0.519176   7.257900e-08
% 1.400000    0.532793    0.532795   1.175350e-06
% 1.500000    0.549572    0.549574   1.879694e-06
% 1.600000    0.569410    0.569412   2.360021e-06
% 1.700000    0.592277    0.592280   2.715255e-06
% 1.800000    0.618203    0.618206   2.999424e-06
% 1.900000    0.647261    0.647264   3.244031e-06
% 2.000000    0.679567    0.679570   3.468138e-06