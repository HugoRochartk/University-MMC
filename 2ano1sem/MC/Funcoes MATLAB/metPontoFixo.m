    function [alfa,iteradas,est_erros] = metPontoFixo(g,x0,tol,maxit,tab)
    % metPontoFixo Implementa o m�todo do ponto fixo
    % 
    %  [alfa,iteradas,est_erros]  = metPontoFixo(g,x0,tol,maxit,tab)
    %   C�lculo de uma sequ�ncia de aproxima��es para um ponto fixo de 
    %   uma fun��o g (e de estimativas para os respetivos erros), 
    %   usando o m�todo do ponto fixo.
    %
    %   O processo iterativo � inicializado com uma aproxima��o inicial x0
    %   e � interrompido quando: 
    %     (i) o valor absoluto da diferen�a das duas �ltimas iteradas
    %         calculadas (estimativa para o erro na �ltima iterada) for 
    %         inferior a uma certa toler�ncia (tol)
    %                               ou 
    %     (ii) for atingido um n�mero m�ximo de itera��es permitidas (maxit). 
    %
    % INPUT:
    %   g: uma fun��o, cujo ponto fixo queremos calcular
    %   x0: real (aproxima��o inicial)
    %
    % Opcionais:
    %   tol: real positivo (toler�ncia a usar no crit�rio de paragem)
    %        Por defeito, tol = 0.5e-6
    %   maxit: inteiro positivo (n�mero m�ximo de itera��es permitidas)
    %        Por defeito, maxit = 30;
    %   tab : usar tab = 0, se n�o quisermos ver tabela de resultados no ecr�;
    %        Por defeito, tab = 1.
    %
    % OUTPUT:
    %   alfa:  aproxima��o para o ponto fixo
    %  
    % Opcional:
    %   iteradas: (vetor coluna com as sucessivas) aproxima��es para o ponto fixo de g
    %   est_errros: (vetor coluna com) estimativas para os erros nas aproxima��es
    %               

    %-------------------------------------------------------------------------
    % Verificar se existe o n�mero m�nimo de entradas
    %-------------------------------------------------------------------------
    if ( nargin < 2 )
       error('Tem que indicar a fun��o e a aproxima��o inicial')
    end
    %--------------------------------------------------------------------------
    %       Valores de argumentos por defeito
    %--------------------------------------------------------------------------
    if ( nargin <5 ); tab = 1; end
    if ( nargin <4 || isempty(maxit)); maxit = 30; end
    if ( nargin <3 || isempty(tol));   tol = 0.5e-6; end

    if (tol <= 0)
        error('tol deve ser positivo')
    end
    if (fix(maxit)~=maxit||maxit<0)
        error('maxit deve ser um inteiro n�o negativo')
    end

    %------------------------------------------------------------------------
    %                       PROCESSO ITERATIVO
    %------------------------------------------------------------------------
    iteradas = zeros(maxit,1); % Inicializa��o dos vetores iteradas 
                               % e est_erros com zeros
    est_erros = zeros(maxit,1);
    %
    for niter = 1:maxit     
        nova_iterada = g(x0);            % C�lculo da nova aproxima��o 
        iteradas(niter) = nova_iterada;  % Atualiza��o do vetor das iteradas
        est = abs(nova_iterada-x0);      % C�lculo da estimativa para o erro 
        est_erros(niter) = est;          % Atualiza��o do vetor da estimativas
        if est < tol            
            break
        end
        x0 = nova_iterada; % Atualiza��o de x0 com o valor da �ltima iterada calculada 
    end
    %
    if (niter == maxit && (est >= tol||isnan(est))) % Pode ter atingido a tolerancia na �ltima
                                                    % itera��o
        disp(' ')
        disp(['Ao fim de ',num2str(maxit), ' itera��es n�o se atingiu a precis�o desejada'])
        disp(' ') 
    else
        disp(' ')
        disp(['Atingimos a precis�o desejada em  ',num2str(niter), ' itera��es'])
        disp(' ')
    end 
    %
    iteradas(niter+1:end) =  [];  %  "Apagar" os valores n�o calculados                            
    est_erros(niter+1:end) = []; %   (que foram inicializados como zero) 
    alfa = iteradas(end);  %  A  aproxima��o fornecida para o ponto fixo
                               %  � a �ltima iterada calculada
    if tab ~=0 % Se quisermos ver a tabela
           num_iteradas = length(iteradas);
           tabela=[(1:num_iteradas)',iteradas,est_erros]';
           disp('_______________________________')
           disp(['  k ','      x_k   ', '    Est. erro  '])
           disp('_______________________________')
           fprintf('%3.0f   %10.6f   %10.2e\n',tabela)
           disp('_______________________________')
    end
end
