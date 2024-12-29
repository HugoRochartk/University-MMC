function raizes = metWeierstrass(f, x0, tol, maxit)
    % metWeierstrass Implementa o método de Weierstrass
    %
    % INPUT:
    %   f: função (polinómio) 
    %   x0: aproximações iniciais para as raízes
    %   tol: tolerância para o critério de paragem (padrão: 1e-6)
    %   maxit: número máximo de iterações (padrão: 100)
    %
    % OUTPUT:
    %   raizes: aproximações para as raízes da função

    if nargin < 3
        tol = 1e-6; 
    end
    if nargin < 4
        maxit = 100; 
    end
    
    n = length(x0); 
    raizes = x0; 
    
    for it=1:maxit
        raizes_old = raizes; 
        for j=1:n
            pj = f(raizes(j));
            
            denom = 1;
            for k = 1:n
                if k ~= j
                    denom = denom * (raizes(j) - raizes(k));
                end
            end
            
            raizes(j) = raizes(j) - (pj / denom);
        end
        
        % Critério de paragem
        if norm(raizes - raizes_old, inf) < tol
            fprintf('Método convergiu em %d iterações.\n', it);
            return;
        end
    end
    
    fprintf('Método não convergiu após %d iterações.\n', maxit);

end
