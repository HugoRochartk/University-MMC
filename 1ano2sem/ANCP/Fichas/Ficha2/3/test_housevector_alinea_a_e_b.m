% Exemplos
x1 = [1; 2; 3];
[v, v_Householder] = housevector(x1);
disp(v_Householder); % Mostrar resultado final


e1 = [1;0;0]; % 1ª coluna da identidade


x1 - norm(x1)*e1 , v % Comparação dos 2 vetores (iguais)


x2 = [-3; 1; 12];
[v2, v_Householder_2] = housevector(x2);
disp(v_Householder_2); % Mostrar resultado final

x2 - norm(x2)*e1 , v2 % Comparação dos 2 vetores (iguais)



% O cancelamento subtrativo evita-se no cálculo da primeira componente do
% vetor v (v(1)) que é calculado de maneira diferente consoante o sinal da
% primeira componente do vetor de entrada x (x(1)). Se x1 não for positivo,
% então o calculo do v1 é dado por x1-miu e como x1<=0 e miu>=0, então x1 e
% -miu são ambos <=0, não ocorrendo cancelamento subtrativo. Caso x1>0 então
% v1 é calculado através da fórmula v(1) = (-sigma) / (x(1) + miu), neste caso,
% x1>0 e miu também, logo, não existirá subtração e, consequentemente, 
% não ocorrerá cancelamento subtrativo.

