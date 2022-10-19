function G = hesseig(H)
    [W,T] = size(H,2,3);
    G = zeros(W,W,T,3);
    for t = 1:T
        for i = 1:W
            for j = 1:W
                v = sort(abs(eig(squeeze(H(i,j,t,:,:)))));
                G(i,j,t,1) = v(2)/v(3);
                G(i,j,t,2) = v(1)/sqrt(v(2)*v(3));
                G(i,j,t,3) = norm(v);
            end
        end
    end
end