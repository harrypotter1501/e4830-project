function vol2gif(img,sliceNums,filename)
    % convert a slice viewer to gif
    s = sliceViewer(img);
    hAx = getAxesHandle(s);
    for idx = 1:sliceNums
        % Update slice number
        s.SliceNumber = idx;
        % Use getframe to capture image
        I = getframe(hAx);
        [indI,cm] = rgb2ind(I.cdata,256);
        % Write frame to the GIF file
        if idx == 1
            imwrite(indI,cm,filename,'gif','Loopcount',inf,'DelayTime', 0.05);
        else
            imwrite(indI,cm,filename,'gif','WriteMode','append','DelayTime', 0.05);
        end
    end
end