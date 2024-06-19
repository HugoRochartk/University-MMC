function [ valE ] = funE(w,X,Y)
%função objetivo E (= função custo E) 

I=length(w)-1;  %grau do polinomio;
n=length(X);

valE=0;
for i=1:n
    valE=valE + (funphi(w,X(i),I)-Y(i))^2;
end
valE=valE/n;


end

