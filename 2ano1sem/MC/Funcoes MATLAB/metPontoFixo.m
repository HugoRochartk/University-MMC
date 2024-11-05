    function [alfa,iteradas,est_erros] = metPontoFixo(g,x0,tol,maxit,tab)
    % metPontoFixo Implementa o método do ponto fixo
    % 
    %  [alfa,iteradas,est_erros]  = metPontoFixo(g,x0,tol,maxit,tab)
    %   Cálculo de uma sequência de aproximações para um ponto fixo de 
    %   uma função g (e de estimativas para os respetivos erros), 
    %   usando o método do ponto fixo.
    %
    %   O processo iterativo é inicializado com uma aproximação inicial x0
    %   e é interrompido quando: 
    %     (i) o valor absoluto da diferença das duas últimas iteradas
    %         calculadas (estimativa para o erro na última iterada) for 
    %         inferior a uma certa tolerância (tol)
    %                               ou 
    %     (ii) for atingido um número máximo de iterações permitidas (maxit). 
    %
    % INPUT:
    %   g: uma função, cujo ponto fixo queremos calcular
    %   x0: real (aproximação inicial)
    %
    % Opcionais:
    %   tol: real positivo (tolerância a usar no critério de paragem)
    %        Por defeito, tol = 0.5e-6
    %   maxit: inteiro positivo (número máximo de iterações permitidas)
    %        Por defeito, maxit = 30;
    %   tab : usar tab = 0, se não quisermos ver tabela de resultados no ecrã;
    %        Por defeito, tab = 1.
    %
    % OUTPUT:
    %   alfa:  aproximação para o ponto fixo
    %  
    % Opcional:
    %   iteradas: (vetor coluna com as sucessivas) aproximações para o ponto fixo de g
    %   est_errros: (vetor coluna com) estimativas para os erros nas aproximações
    %               

    %-------------------------------------------------------------------------
    % Verificar se existe o número mínimo de entradas
    %-------------------------------------------------------------------------
    if ( nargin < 2 )
       error('Tem que indicar a função e a aproximação inicial')
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
        error('maxit deve ser um inteiro não negativo')
    end

    %------------------------------------------------------------------------
    %                       PROCESSO ITERATIVO
    %------------------------------------------------------------------------
    iteradas = zeros(maxit,1); % Inicialização dos vetores iteradas 
                               % e est_erros com zeros
    est_erros = zeros(maxit,1);
    %
    for niter = 1:maxit     
        nova_iterada = g(x0);            % Cálculo da nova aproximação 
        iteradas(niter) = nova_iterada;  % Atualização do vetor das iteradas
        est = abs(nova_iterada-x0);      % Cálculo da estimativa para o erro 
        est_erros(niter) = est;          % Atualização do vetor da estimativas
        if est < tol            
            break
        end
        x0 = nova_iterada; % Atualização de x0 com o valor da última iterada calculada 
    end
    %
    if (niter == maxit && (est >= tol||isnan(est))) % Pode ter atingido a tolerancia na última
                                                    % iteração
        disp(' ')
        disp(['Ao fim de ',num2str(maxit), ' iterações não se atingiu a precisão desejada'])
        disp(' ') 
    else
        disp(' ')
        disp(['Atingimos a precisão desejada em  ',num2str(niter), ' iterações'])
        disp(' ')
    end 
    %
    iteradas(niter+1:end) =  [];  %  "Apagar" os valores não calculados                            
    est_erros(niter+1:end) = []; %   (que foram inicializados como zero) 
    alfa = iteradas(end);  %  A  aproximação fornecida para o ponto fixo
                               %  é a última iterada calculada
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
