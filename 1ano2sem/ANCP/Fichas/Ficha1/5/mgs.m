function [Q,R]=mgs(A)


[m, n]=size(A );

R = zeros(n,n);
Q = zeros(m,n);

for j=1:n 
    Q(:,j)=A(:,j);
    for i=1:j-1 
        R(i,j)=Q(:,i)'*Q(:,j);
        Q(:,j)=Q(:,j)-R(i,j)*Q(:,i);
    end
    R(j,j)=norm(Q(:,j));
    Q(:,j)=Q(:,j)/R(j,j);
end
end