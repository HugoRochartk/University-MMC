function [ Yp] = Classificador( w0,w,Xv )
%

% classificador: � definido pela fun��o sinal (do valor dado pelo Hiperplano)
 Yp=sign(w0+w'*Xv)';
end

