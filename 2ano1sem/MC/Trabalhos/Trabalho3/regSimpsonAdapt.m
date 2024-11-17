function [int_Aprox, est_erro, N] = regSimpsonAdapt(f, a, b, tol, N)


[int_Aprox, est_erro] = erroSimpson(f,a,b,N);

if est_erro > tol
    N = N + 4;
    [int_Aprox, est_erro, N] = regSimpsonAdapt(f,a,b,tol,N);
end


end
