%x = [1 2 3 4 5 6]; %deu igual
%x = [1e-10, 1e-10 - 1e-30, 1e-10 - 1e-31]; %deu igual
x = [1e10+1, 1e10+2, 1e10+3]; %deu diferente

[media, desvio1, desvio2] = mediaDesvios(x)

% A diferença de resultados deve-se ao facto de na segunda fórmula de
% cálculo do desvio padrão acedermos ao valor quadrado de cada uma das
% componentes de x e da média das mesmas, que, como são valores
% astronómicos, ao fazer a subtração entre os mesmos, a diferença será
% pequena em relação aos valores originais o que pode resultar em perda de 
% precisão devido ao cancelamento de dígitos significativos. A primeira
% formula neste caso parece ser mais resistente a esse tipo de problemas já
% que calcula diretamente as diferenças entre cada componente e a média o 
% que minimiza esses problemas, pois os valores envolvidos são menores.