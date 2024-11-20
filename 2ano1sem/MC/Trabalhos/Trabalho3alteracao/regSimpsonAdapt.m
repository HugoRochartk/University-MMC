function integral = regSimpsonAdapt(f, a, b, tol)

end
    


function S = regSimpsonSimples(f, a, b)

    h = b - a;
    m = (b - a) / 2;
    
    S = (h/3) * (f(a) + 4*f(m) + f(b));

end