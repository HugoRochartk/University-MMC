function [Q,R]=mgsr(A, flag)


if nargin < 2 || isempty(flag)
        flag = 1;
end

[m, n]=size(A);

R = zeros(n,n);
Q = zeros(m,n);

for j=1:n 
    Q(:,j)=A(:,j);
    for i=1:j-1 
        R(i,j)=Q(:,i)'*Q(:,j);
        Q(:,j)=Q(:,j)-R(i,j)*Q(:,i);
    end
    if flag==1
        for i=1:j-1
            S(i,j)=Q(:,i)'*Q(:,j);
            Q(:,j)=Q(:,j)-S(i,j)*Q(:,i);
            R(i,j)=R(i,j)+S(i,j);
        end
    end
    R(j,j)=norm(Q(:,j));
    Q(:,j)=Q(:,j)/R(j,j);
end
end