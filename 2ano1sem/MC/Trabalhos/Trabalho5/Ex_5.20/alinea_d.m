% Exercício 5.20. alínea d)

%Definir opções
options = odeset('Stats', 'on', 'AbsTol', 1e-10, 'RelTol', 1e-10);

%Definir a equação diferencial
eqdif = @(x, y) y;

%Condições
span = 0:0.2:1;
y0 = 1;

%Calcular esforços e tempos de CPU
fprintf('\n--------------- ODE23T -----------------\n')
tic;
[t1, y1] = ode23t(eqdif, span, y0, options);
toc;
fprintf('\n--------------- ODE23TB ----------------\n')
tic;
[t2, y2] = ode23tb(eqdif, span, y0, options);
toc;
fprintf('\n--------------- ODE113 -----------------\n')
tic;
[t3, y3] = ode113(eqdif, span, y0, options);
toc;
fprintf('\n---------------- ODE23 -----------------\n')
tic;
[t4, y4] = ode23(eqdif, span, y0, options);
toc;
fprintf('\n---------------- ODE45 -----------------\n')
tic;
[t5, y5] = ode45(eqdif, span, y0, options);
toc;


%OUTPUT:

% --------------- ODE23T -----------------
% 1263 successful steps
% 0 failed attempts
% 1272 function evaluations
% 1 partial derivatives
% 6 LU decompositions
% 1269 solutions of linear systems
% Elapsed time is 0.012994 seconds.

% --------------- ODE23TB ----------------
% 1057 successful steps
% 0 failed attempts
% 2120 function evaluations
% 1 partial derivatives
% 3 LU decompositions
% 3174 solutions of linear systems
% Elapsed time is 0.016316 seconds.

% --------------- ODE113 -----------------
% 37 successful steps
% 0 failed attempts
% 75 function evaluations
% Elapsed time is 0.001820 seconds.

% ---------------- ODE23 -----------------
% 742 successful steps
% 0 failed attempts
% 2227 function evaluations
% Elapsed time is 0.002877 seconds.

% ---------------- ODE45 -----------------
% 31 successful steps
% 0 failed attempts
% 187 function evaluations
% Elapsed time is 0.002707 seconds.
