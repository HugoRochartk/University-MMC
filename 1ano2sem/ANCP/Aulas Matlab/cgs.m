function [Q,R]=cgs(A)


[n, m]=size(A );

R = zeros(m,m);
Q = zeros(n,m);

for j=1:m 
    Q(:,j)=A(:,j);
    for i=1:j-1 
        R(i,j)=Q(:,i)'*A(:,j);
        Q(:,j)=Q(:,j)-R(i,j)*Q(:,i);
    end
    R(j,j)=norm(Q(:,j));
    Q(:,j)=Q(:,j)/R(j,j);
end
end

