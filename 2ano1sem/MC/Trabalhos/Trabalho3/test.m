f = @(x) x.^2;

[int_Aprox, est_erro] = regSimpsonAdapt(f, 0, 2, 1*10^(-6), 4)