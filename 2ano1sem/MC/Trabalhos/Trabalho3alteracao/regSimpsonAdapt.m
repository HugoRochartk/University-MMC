function [integral, pontos] = regSimpsonAdapt(f, a, b, tol, pontos)

    S = regSimpsonSimples(f, a, b);

    m = (a + b) / 2;

    S1 = regSimpsonSimples(f, a, m);
    S2 = regSimpsonSimples(f, m, b);

    est_erro = abs(S1 + S2 - S) / 15;

    if est_erro <= tol
        pontos = [pontos, [a, m ,b]]; 
        integral = S1 + S2;
    else
        [int1, pontos1] = regSimpsonAdapt(f, a, m, tol, pontos);
        [int2, pontos2] = regSimpsonAdapt(f, m, b, tol, pontos);

        integral = int1 + int2;
        pontos = [pontos1, pontos2];
    end

end


function S = regSimpsonSimples(f, a, b)

    m = (a + b) / 2;
    h = b - a;

    S = (h / 6) * (f(a) + 4 * f(m) + f(b));

end

