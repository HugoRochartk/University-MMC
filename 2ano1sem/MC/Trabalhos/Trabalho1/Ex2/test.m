% a)
myeneg25 = funSerie101(-25) % 8.0866e-07

% b)
myeinv25 = 1/funSerie101(25) % 1.3888e-11

% c)
eneg25matlabexp = exp(-25) % 1.3888e-11

% o resultado da alínea a) não é o mesmo que o resultado da função exp do
% Matlab porque como estamos a calcular e^(-25) com base na série existe
% alternância no sinal de cada termo conforme a paridade do expoente e essa
% alternância na magnitude e sinal dos valores leva a perda de precisão nos
% cálculos, nomeadamente, a cancelamento numérico ou subtrativo. Isto não
% acontece no cálculo de e^25 pois não existem subtrações e não existe
% alternância de sinal daí o resultado ser o mesmo que o da função exp do
% Matlab.

