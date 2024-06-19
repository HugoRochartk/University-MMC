A = hilb(10); % Matriz de Hilbert
b = ones(10, 1); % Vetor b com todos os elementos iguais a 1

% Fatorização QR
[Q, R] = qrhouseholder_3c(A);

c = Q'*b;

x_QR = R \ c;



% Resolver o sistema usando o operador backslash do MATLAB
x_BL = A \ b;

% Calcular o resíduo relativo
residual_QR = norm(A*x_QR - b)
residual_BL = norm(A*x_BL - b)

% Mostrar os resultados
disp('Resíduo relativo usando a função qrhouseholder:');
disp(residual_QR);
disp('Resíduo relativo usando o operador backslash:');
disp(residual_BL);