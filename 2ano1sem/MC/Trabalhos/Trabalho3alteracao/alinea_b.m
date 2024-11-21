% Definir função do integral
f = @(x) 1 ./ (1 + 25 * (x.^2));


% Cálculo do integral através da função definida regSimpsonAdapt
[int_Aprox, pontos] = regSimpsonAdapt(f, -1, 1, 10^-4, []);
format long g
int_Aprox
% Resultado: int_Aprox = 0.549373023629104


% Valor real usando função do MATLAB
integral(f, -1, 1)
% Resultado 0.549360306778007