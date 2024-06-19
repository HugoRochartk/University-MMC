%define variaveis simbolicas
syms x1 x2
%definir a funcao F
F = x1 + x2 + (1/2)*(x1^2 * x2^2) - ((x1 + x1^2 + x1^3)/(1 + x1^4));

%derivadas de F
grad1=diff(F,x1);%diff calcula a derivada em ordem a...
grad2=diff(F,x2);
vec0=[0;0];
grad=[grad1;grad2];
%o gradiente é um vetor coluna com as derivadas em ordem as variaveis
hess=[diff(grad1,x1) diff(grad1,x2);
    diff(grad2,x1) diff(grad2,x2)];
fprintf('gradiente de F:\n'); disp(grad)
fprintf('Hessiana de F:\n'); disp(hess)
%calculo dos pontos estacionarios
[xs1 xs2]=solve(grad==vec0,[x1,x2]);
fprintf('Pontos estacionarios de F:\n'); disp(double([xs1 xs2]))
[n nc]=size(xs1);  %existem n pontos estacionarios
[dim dim1]=size(hess);  %dimensao da hessiana 
    %calcular a Hessiana em cada ponto estacionario
    hessxs=subs(hess,[x1 x2],[double(0) double(-1)]);
    fprintf('Hessiana de F no ponto:')
    disp(double([0 -1])); disp(hessxs)
    %calculo dos determinantes das submatrizes principais
    for j=1:dim
       A=hessxs(1:j,1:j);
       d(j)=det(A);
    end
    fprintf('Determinantes das submatrizes principais da Hessiana:\n')
    disp(d) %determinante de cada submatriz de hessxs
    %verificar se hessiana e defpos/defneg, semidefpos/semidefneg ou indef
    nulo=0;
    pos=0;
    neg=0;
    indf=0;
    for j=1:dim
        if double(d(j))>0
            pos=pos+1;
        elseif double(d(j))<0
            if (j==1)
                neg=neg+1;
            elseif(j==2*(j-2)-1) % numero impar
               neg=neg+1;
           else
               indf=1;
           end
       else
           nulo=nulo+1;
       end
   end
   if nulo==0
       switch dim
        case pos
            fprintf('A matriz e definida positiva.\n')
            fprintf('A funcao tem um minimo local estrito no ponto:\n')
            disp(([xs1(i) xs2(i)]))
            min=double(subs(F,[x1 x2],[xs1(i) xs2(i)]))
        case (pos+neg)
            fprintf('A matriz e definida negativa.\n')
            fprintf('A funcao tem um maximo local estrito no ponto:\n')
            disp(double([xs1(i) xs2(i)]))
            max=subs(F,[x1 x2],[xs1(i) xs2(i)])
        otherwise
            fprintf('A matriz e indefinida.\n')
            fprintf('E um ponto sela de F:\n')
            disp(double([xs1(i) xs2(i)]))
        end
    else
        switch dim
         case (nulo+pos)
            fprintf('A matriz e semidefinida positiva\n')
        case (nulo+pos+neg)
            fprintf('A matriz e semidefinida negativa\n')
        otherwise
            fprintf('A matriz e indefinida\n')
        end
    end

        
%grafico de F
%ezcontour(F, [-10 5 -15 0])
ezsurfc(F,[-500 500])


