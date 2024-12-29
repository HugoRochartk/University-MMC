%Função f
f = @(x) x.^3 + 2*x.^2 - 7*x + 1;   

%Derivada da função f
fderiv = @(x) 3*x.^2 + 4*x - 7;     



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
x0 = [-5, 5, 0.75];   
%Tolerância
tol = 10^-6;
%Número máximo de iterações
maxit = 30;   
%Mostrar tabela de resultados
tab = 1;    

for i=1:3
    [r, iteradas, est_erros] = metNewton(f, fderiv, x0(i), tol, maxit, tab);
    
    fprintf('A aproximação da raiz com x0=%.2f é: %.6f\n', x0(i), r);
end



% OUTPUT:

%Atingimos a precisão desejada em  4 iterações
%_______________________________
%  k       x_k       Est. erro  
%_______________________________
%  0    -5.000000     8.12e-01
%  1    -4.187500     2.79e-01
%  2    -3.908674     3.45e-02
%  3    -3.874211     5.11e-04
%  4    -3.873700     1.12e-07
%_______________________________
%A aproximação da raiz com x0=-5.00 é: -3.873700
 


%Atingimos a precisão desejada em  6 iterações 
%_______________________________
%  k       x_k       Est. erro  
%_______________________________
%  0     5.000000     1.60e+00
%  1     3.397727     9.59e-01
%  2     2.438827     5.01e-01
%  3     1.937354     1.85e-01
%  4     1.752770     2.82e-02
%  5     1.724607     6.50e-04
%  6     1.723957     3.44e-07
%_______________________________
%A aproximação da raiz com x0=5.00 é: 1.723957



%Atingimos a precisão desejada em  4 iterações 
%_______________________________
%  k       x_k       Est. erro  
%_______________________________
%  0     0.750000     1.17e+00
%  1    -0.418919     5.17e-01
%  2     0.097684     5.11e-02
%  3     0.148778     9.65e-04
%  4     0.149743     3.60e-07
%_______________________________
%A aproximação da raiz com x0=0.75 é: 0.149743