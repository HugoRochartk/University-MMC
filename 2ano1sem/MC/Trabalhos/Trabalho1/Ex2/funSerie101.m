function res = funSerie101(x)
    res = 1;
    for n=1:100
        res = res+(x^n)/(factorial(n));
    end
end
