function G = tubular(H,a,b,c)
    e = @(x,s) exp(-x.^2/(2*s^2));
    G = (1-e(H(:,:,:,1),a)).*e(H(:,:,:,2),b).*(1-e(H(:,:,:,3),c));
end