% Exercício 5.20. alínea b)

%Definir opções
options = odeset('Stats', 'on', 'AbsTol', 1e-10, 'RelTol', 1e-10);

%Definir a equação diferencial
eqdif = @(x, y) y;

%Condições
span = 0:0.2:1;
y0 = 1;

%Aumentar casas decimais
format long g 

%Resolução com ode23t
[t1, y1] = ode23t(eqdif, span, y0, options)

%Resolução com ode23tb
[t2, y2] = ode23tb(eqdif, span, y0, options)

%Resolução com ode113
[t3, y3] = ode113(eqdif, span, y0, options)


%OUTPUT:

% 1263 successful steps
% 0 failed attempts
% 1272 function evaluations
% 1 partial derivatives
% 6 LU decompositions
% 1269 solutions of linear systems

% t1 =

%                          0
%                        0.2
%                        0.4
%                        0.6
%                        0.8
%                          1

% y1 =

%                          1
%           1.22140277106064
%           1.49182472912761
%           1.82211885806497
%           2.22554102241997
%           2.71828197181341

% 1057 successful steps
% 0 failed attempts
% 2120 function evaluations
% 1 partial derivatives
% 3 LU decompositions
% 3174 solutions of linear systems

% t2 =

%                          0
%                        0.2
%                        0.4
%                        0.6
%                        0.8
%                          1

% y2 =

%                          1
%           1.22140276699691
%            1.4918247192337
%           1.82211883995695
%            2.2255409929673
%           2.71828192690487

% 37 successful steps
% 0 failed attempts
% 75 function evaluations

% t3 =

%                          0
%                        0.2
%                        0.4
%                        0.6
%                        0.8
%                          1

% y3 =

%                          1
%           1.22140275815893
%            1.4918246976365
%           1.82211880037949
%           2.22554092843631
%           2.71828182836597


