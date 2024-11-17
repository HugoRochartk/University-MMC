% Definir função do integral
f = @(x) 1 ./ (1 + 25 * (x.^2));

% Cálculo do integral através da função definida regSimpsonAdapt
[int_Aprox, est_erro, N] = regSimpsonAdapt(f, -1, 1, 1*10^-4, 4)
% Resultado: int_Aprox = 0.5494; est_erro = 9.9040e-05; N = 36;

% Valor real usando função do MATLAB

format long g
integral(f, -1, 1)
% Resultado 0.549360306778007