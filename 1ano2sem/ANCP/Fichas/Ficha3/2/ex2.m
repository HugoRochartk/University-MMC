%1ª secção
A = imread('street1.jpg');
A = rgb2gray(A);
imshow(A)
title(sprintf('Original (Rank %d)',rank(double(A))))

%Esta secção tem como output a imagem relativa a "street1.jpg" mas
%numa escala de cinza (informalmente preto e branco). Além disso indica 
%também a característica da matriz A (480) que corresponde à matriz de 
%informação da imagem em questão.




%2ª secção
[U1,S1,V1] = svdsketch(double(A),1e-2);
Anew1 = uint8(U1*S1*V1');
imshow(Anew1)
title(sprintf('Rank %d approximation',size(S1,1)))


%Esta secção começa por realizar a decomposição SVD da matriz A referente
%à imagem falada anteriormente com uma tolerância de 10^(-2) para 
%determinar de forma adaptativa a característica da matriz de aproximação 
%do esboço da matriz A. Após isso, é reconstituída esta nova matriz de 
%aproximação e imprimida junto com a sua característica (288).




%3ª secção
[U2,S2,V2] = svdsketch(double(A),1e-1);
Anew2 = uint8(U2*S2*V2');
imshow(Anew2)
title(sprintf('Rank %d approximation',size(S2,1)))


%Esta secção é semelhante à anterior havendo apenas um valor da tolerância
%mais elevado o que deverá causar uma aproximação menos fiável a A, já que
%quanto maior o valor da tolerância, menos recursos de A são usados ​​no 
%esboço da matriz. O output é novamente uma aproximação da imagem relativa 
%à matriz A mas desta vez é percetível que a aproximação é de muito menos
%qualidade. A característica dessa matriz aproximada tomou o valor de 48.





%4ª secção
[U3,S3,V3,apxErr] = svdsketch(double(A),1e-1,'MaxSubspaceDimension',15);
Anew3 = uint8(U3*S3*V3');
imshow(Anew3)
title(sprintf('Rank %d approximation',size(S3,1)))



%Esta secção é também semelhante à anterior mantendo o mesmo valor para a
%tolerância na decomposição SVD, no entanto, é adicionado um novo argumento
%que restringe a dimensão do subespaço a 15 (ou seja o valor da 
%característica será 15) o que deverá causar uma perda de informação no 
%cálculo da aproximação relativamente elevada. Ao imprimir a nova imagem é 
%notável a perda de informação e, como expectável, a característica da 
%matriz de aproximação fixou fixada a 15.




