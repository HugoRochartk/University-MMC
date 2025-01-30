% Exercício 5.26. alíneas a), c) e d)

edit vdpode;

vdpode(2);
vdpodeRK(2);

vdpode(100);
vdpodeRK(100);

vdpode(200);
vdpodeRK(200);


% Alínea d)

% Pela análise dos gráficos podemos ver que estamos perante um problema
% rígido/stiff. A rigidez ocorre porque as soluções/gráficos apresentam 
% regiões onde oscilam lentamente e outras onde oscilam rapidamente.
% Em regiões de oscilação rápida, pequenos passos de tempo são necessários 
% para garantir estabilidade, no entanto, em regiões de oscilação lenta,
% passos maiores serão suficientes (mexer na variável tspan).