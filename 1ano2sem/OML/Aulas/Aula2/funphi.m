function [val]= funphi(w,xn,I)
%ex: compute the value of the  polynomial of degree I: funphi(w,xn)=w0*xn^0+w1*xn^1+...+wI*xn^I

val=dot(w,power(xn,0:I));    %dot=inner produt:  w0*xn^0+w1*xn^1+...+wI*xn^I

end