function print_video_cwt(traces_number, fps)

    fig = figure;
    for i = 1:traces_number
       cwt(csvread(strcat('../../../../data/csvs/DPAv2/part0/tr',num2str(i),'.csv')));
       title(strcat('Trace ',num2str(i)));
       F(i) = getframe(fig);                   % capture it
    end
    path = '../../../../data/figs/DPAv2/';
    writerObj = VideoWriter(strcat(path, num2str(traces_number),...
            '_traces_cwt-', num2str(fps),'_fps.avi')); 
    writerObj.FrameRate = fps;
    open(writerObj);
    writeVideo(writerObj, F)
    close(writerObj)
return