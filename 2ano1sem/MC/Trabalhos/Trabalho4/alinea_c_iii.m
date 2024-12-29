%Função f
f = @(x) x.^3 + 2*x.^2 - 7*x + 1;  

% Coeficientes do polinómio f(x)
coef = [1 2 -7 1]; 
% Cálculo das raízes reais do polinómio
format long g
raizes = roots(coef);
%raizes =

%         -3.87369990224815
%         1.72395648949113
%         0.149743412757014


% Coeficientes a_i
a0 = 1;
a1 = -7;
a2 = 2;
a3 = 1;

% Fórmulas de Vieta

% r1 + r2 + r3 = - (a2/a3) = - (2/1) = -2;
% r1*r2 + r1*r3 + r2*r3 = a1/a3 = -7/1 = -7;
% r1*r2*r3 = (-1)^3 * (a0/a3) = -1 * (1/1) = -1;

% Sistema final
% { r1 + r2 + r3 + 2 = 0;
% { r1*r2 + r1*r3 + r2*r3 + 7 = 0;
% { r1*r2*r3 + 1 = 0;

f1 = @(r1, r2, r3) r1 + r2 + r3 + 2;
f2 = @(r1, r2, r3) r1*r2 + r1*r3 + r2*r3 + 7;
f3 = @(r1, r2, r3) r1*r2*r3 + 1;

%Derivadas parciais (Jacobi)
J = @(r1, r2, r3) [
                    1, 1, 1;                   %Derivadas parciais de f1
                    r2 + r3, r1 + r3, r1 + r2; %Derivadas parciais de f2
                    r2*r3, r1*r3, r1*r2;       %Derivadas parciais de f3
                  ];


%Aplicação do Método de Newton

%Número máximo de iterações
maxit = 30;
%Tolerância
tol = 10^-6;
%Aproximações iniciais
x0 = [-50, 50, 20];  

for it=1:maxit
    % Avaliar as funções e a matriz Jacobiana
    F = [
        f1(x0(1), x0(2), x0(3)); 
        f2(x0(1), x0(2), x0(3)); 
        f3(x0(1), x0(2), x0(3))
        ];

    newJ = J(x0(1), x0(2), x0(3));
    
    % Resolver o sistema J * delta = F em ordem a delta
    delta = newJ \ F;
    
    % Atualizar as aproximações
    x0 = x0 - delta';
    
    % Condição de paragem
    if norm(delta, inf) < tol
        r1 = x0(1);
        r2 = x0(2);
        r3 = x0(3);
        raizes =[r1 r2 r3];
        fprintf('Método convergiu em %d iterações.\n', it);
        break
    end
end

if (it == maxit)
    % Não convergência
    r1 = x0(1);
    r2 = x0(2);
    r3 = x0(3);
    raizes =[r1 r2 r3];
    fprintf('Método não convergiu após %d iterações.\n', maxit);
end


raizes


% OUTPUT:

% Método convergiu em 13 iterações.

% raizes =

%        0.149743412757014        1.72395648949113       -3.87369990224815
