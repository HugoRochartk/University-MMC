% Exercício 5.20. alínea c)

%Definir opções
options = odeset('Stats', 'on', 'AbsTol', 1e-10, 'RelTol', 1e-10);

%Definir a equação diferencial
eqdif = @(x, y) y;

%Condições
span = 0:0.2:1;
y0 = 1;

%Aumentar casas decimais
format long g

%Resolução com ode23
[t4, y4] = ode23(eqdif, span, y0, options)

%Resolução com ode45
[t5, y5] = ode45(eqdif, span, y0, options)


%OUPUT:

% 742 successful steps
% 0 failed attempts
% 2227 function evaluations

% t4 =

%                          0
%                        0.2
%                        0.4
%                        0.6
%                        0.8
%                          1

% y4 =

%                          1
%           1.22140275813522
%            1.4918246975803
%           1.82211880027875
%            2.2255409283104
%           2.71828182818125

% 31 successful steps
% 0 failed attempts
% 187 function evaluations

% t5 =

%                          0
%                        0.2
%                        0.4
%                        0.6
%                        0.8
%                          1

% y5 =

%                          1
%           1.22140275817467
%           1.49182469766572
%           1.82211880042853
%           2.22554092854854
%            2.7182818284885

