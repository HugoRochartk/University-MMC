% Exercício 5.18. (i) (ii)
 
function results = metPC4(f, x0, y0, h, N)

    %Inicialização do método com os três primeiros valores
    [x, y] = runge_kutta_4(f, x0, y0, h, 3);
    results = [x, y];
    
    %AB4-AM4
    for k = 4:N
        %Valores de f
        f_values = [f(results(k-3,1), results(k-3,2));
                    f(results(k-2,1), results(k-2,2));
                    f(results(k-1,1), results(k-1,2));
                    f(results(k,1), results(k,2))];
        
        %Predição
        y_pred = results(k,2) + h/24 * (55*f_values(4) - 59*f_values(3) + 37*f_values(2) - 9*f_values(1));
        
        %Correção
        x_next = results(k,1) + h;
        f_next = f(x_next, y_pred);
        y_next = results(k,2) + h/24 * (9*f_next + 19*f_values(4) - 5*f_values(3) + f_values(2));
        
        %Adicionar ponto
        results = [results; x_next, y_next];
    end
end

function [x, y] = runge_kutta_4(f, x0, y0, h, steps)

    %Método de Runge-Kutta de 4ª ordem
    x = zeros(steps+1, 1);
    y = zeros(steps+1, 1);
    x(1) = x0;
    y(1) = y0;
    for i = 1:steps
        k1 = h * f(x(i), y(i));
        k2 = h * f(x(i) + h/2, y(i) + k1/2);
        k3 = h * f(x(i) + h/2, y(i) + k2/2);
        k4 = h * f(x(i) + h, y(i) + k3);
        y(i+1) = y(i) + (k1 + 2*k2 + 2*k3 + k4) / 6;
        x(i+1) = x(i) + h;
    end

end
