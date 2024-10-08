function [media, desvio1, desvio2] = mediaDesvios(x)
    
    n = length(x);

    %calcular média
    sum = 0;
    for i=1:n
        sum = sum + x(i);
    end
    media = sum/n;

    %calcular desvio1 (2.1)
    sum = 0;
    for i=1:n
        sum = sum + ((x(i)-media)^2);
    end
    desvio1 = ((1/(n-1))*sum)^(0.5);
    
    %calcular desvio2 (2.2)
    sum = 0;
    for i=1:n
        sum = sum + (x(i)^2);
    end
    desvio2 = ((1/(n-1))*(sum - n*(media)^2))^(0.5);


end
    