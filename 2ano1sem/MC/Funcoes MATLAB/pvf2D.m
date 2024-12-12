function y = pvf2D(p, q, r, a, b, h, alfa, beta)
% Resolve a equação
%   y''(x)+p(x)y'(x)+q(x)y(x)=r(x)
% com condições de fronteira 
%   y(a)=alfa   e  y(b)=beta

x = a:h:b; N = length(x)-1;

a = zeros(size(x));  c = a; d = a; v = a;

% Construção dos vetores a,c,d,v
for k = 2:N
    a(k) = 1-(h/2)*p(x(k));
    d(k) = -2+h^2*q(x(k));
    c(k) = 1+(h/2)*p(x(k));
    v(k) = h^2*r(x(k));
end
av = a(3:N); dv = d(2:N); cv = c(2:N - 1);
% Construção da matriz tridiagonal T
T = diag(dv) + diag(av, -1) + diag(cv, 1);
% Construção do vetor v
v(2) = v(2) - a(2)*alfa; 
v(N) = v(N) - c(N)*beta; 
b = v(2:N)';
% Resolução do sistema
y = (T\b)';
% Solução com as condições de fronteira
y = [alfa y beta];
end