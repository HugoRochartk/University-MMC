function [ Yp] = Classificador( w0,w,Xv )
%

% classificador: é definido pela função sinal (do valor dado pelo Hiperplano)
 Yp=sign(w0+w'*Xv)';
end

