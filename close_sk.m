function skel = close_sk(skel)
%     for i = 1:3
%         for j = 1:3
%             s = zeros(3,3,3);
%             s(i,j,1) = 1;
%             s(j,i,3) = 1;
%             skel = imclose(skel,s);
%         end
%     end
%     for i = 1:3
%         s = zeros(3,3,3);
%         s(i,i,2) = 1;
%         s(4-i,4-i,2) = 1;
%         skel = imclose(skel,s);
%     end
    for i = [1,3]
        for j = [1,3]
            s = zeros(3,3,3);
            s([1,2,2,2,2,3],[2,1,2,2,3],[2,2,1,3,2,2]) = 1;
            s(i,j,1) = 1;
            s(4-i,4-j,3) = 1;
            skel = imclose(skel,s);
        end
    end
end