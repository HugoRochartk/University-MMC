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


%Aproximações iniciais
x0 = [-10, 10, 5];   
%Tolerância
tol = 10^-6;
%Número máximo de iterações
maxit = 30;   

%Obter aproximação para raízes
raizes = metWeierstrass(f, x0, tol, maxit)


% OUTPUT:   
    %Método convergiu em 9 iterações.
    
    %raizes =
    
    %        1.72395648949113      -3.87369990224815      0.149743412757014