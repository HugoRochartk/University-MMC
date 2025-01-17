
r = 0;
for i=1:99
    x(i) = r + 0.01;
    r = r + 0.01;
end

n = length(x);

for i=1:n
    if x(i) >= 0 && x(i) < 0.25
        y(i) = 1 + 6*x(i) - 32*(x(i)^3);
    elseif x(i) >= 0.25 && x(i) < 0.5
        y(i) = 2 - 24*(x(i) - 0.25)^2 + 32*(x(i) - 0.25)^3;
    elseif x(i) >= 0.5 && x(i) < 0.75
        y(i) = 1 - 6*(x(i) - 0.5) + 32*(x(i) - 0.5)^3;
    elseif x(i) >= 0.75 && x(i) <= 1
        y(i) = 24*(x(i)-0.75)^2 - 32*(x(i)-0.75)^3;
     
    end
end


plot(x,y, '-o')
          