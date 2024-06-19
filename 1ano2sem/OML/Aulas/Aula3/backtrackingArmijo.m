function [ etak] = backtrackingArmijo(wk,Ek,gradk,sk, Xt,Yt)
%
delta=0.1;
etak=1;

while ( funE(wk+etak*sk,Xt,Yt)>Ek+delta*etak*gradk'*sk )
    etak=etak/2;
    if etak*norm(sk)<=1e-8
        etak=1;
        return
    end
end


end

