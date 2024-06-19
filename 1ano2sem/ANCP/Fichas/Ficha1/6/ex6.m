A = rand([200 160]);


% Introduzir colunas praticamente lineramente dependentes para visualizar melhor as diferenças
A(:, 2:160) = A(:, 1) * ones(1, 159) + randn(200, 159) * 0.01;


[Q_ort,R_ort] = mgsr(A,1);
[Q,R] = mgsr(A,0);



orthogonality1 = norm(Q_ort' * Q_ort - eye(160))
orthogonality2 = norm(Q' * Q - eye(160))


%Sabemos que a matriz é ortogonal se Q'*Q = I, ou seja, uma boa forma de
%calcular a ortogonalidade da matriz Q é fazer a norma da diferença entre
%Q'*Q e a identidade e, quanto mais próximo de 0, melhor será a
%ortogonalidade.


%Como podemos ver nos resultados, a matriz obtida com reortogonalização
%apresenta um valor mais próximo de 0 do que a matriz onde esse processo
%não foi aplicado.