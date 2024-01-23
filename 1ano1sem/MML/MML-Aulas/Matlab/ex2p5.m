C =  {[0 0], [2 1], [2 4], [1 -2], [-3 1]}
Cx = [0 2 2 1 -3]
Cy = [0 1 4 -2 2]


%plot(Cx,Cy,"red")

for i=1:length(C)
    sum = 0;
    for j=1:length(C)
        sum = sum + Manhattan(C{i}, C{j});
    end
    custos(i) = sum;
end


[min_custo, ind] = min(custos)
repre = C{ind}
