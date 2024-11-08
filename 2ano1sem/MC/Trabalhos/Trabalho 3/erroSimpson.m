% Calcula a aproximação do integral da função f no intervalo [a,b] usando
% regra de Simpson bem como o cáluclo do erro estimado
function [S, E] = erroSimpson(f, a, b)
    
    h = (b-a)/2;

    % ponto médio
    m = (a+b)/2;
    
    % aplicação da Regra de Simpson no intervalo [a,b]
    S = (h/3) * (f(a) + 4*f(m) + f(b));
    


    % divisão do intervalo total em dois subintervalos [a,m] e [m,b]
    h1 = (m-a)/2;
    m1 = (a+m)/2;
    h2 = (b-m)/2;
    m2 = (m+b)/2;

    S1 = (h1/3) * (f(a) + 4*f(m1) + f(m));
    S2 = (h2/3) * (f(m) + 4*f(m2) + f(b));
    
    % estimativa do erro
    E = (abs(S1 + S2 - S))/15;
    
    % retorna a soma das áreas dos subintervalos e a estimativa de erro
    S = S1+S2;

end
