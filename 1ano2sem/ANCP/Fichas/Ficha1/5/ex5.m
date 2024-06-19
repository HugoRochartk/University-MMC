A = [1, 9, 0, 5, 3, 2;
    -6, 3, 8, 2, -8, 0;
    3, 15, 23, 2, 1, 7;
    3, 57, 35, 1, 7, 9;
    3, 5, 6, 15, 55, 2;
    33, 7, 5, 3, 5, 7];

%a)

[Q,R] = mgs(A);
 
for i=1:6
    norm(Q(:,i)); %Verificação de que as colunas de Q são ortonormadas (norma 1)
end


Q; %Colunas de Q representam base ortonormada para o espaço gerado pelas colunas de A.




%b)

R;

%O determinante será o produto dos valores absolutos da diagonal de R
qr_det = 1;
for i=1:6
    qr_det = qr_det * abs(R(i,i)); 
end
%A variável qr_det armazena o cálculo do determinante através da matriz R


qr_det, det(A)
%Os valores obtidos nos cálculos do determinante através da matriz R e
%através da função de MATLAB foram iguais (20377808).
