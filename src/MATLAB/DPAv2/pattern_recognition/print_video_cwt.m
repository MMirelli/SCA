function print_video_cwt(traces_number, fps) 
% [] = print_video_cwt
% 
% NOTE: With more than 1000 traces you will need 7.5GB of RAM to run this.

    fs = filesep;
    updir = strcat('..', fs);
    data_path = strcat(updir, updir, updir, 'data', fs);
    
    % 3GB are taken by 1000 frames
    CHUNKS_LENGTH = 1000;
   
    figs_path = strcat (data_path, 'figs', fs, 'DPAv2', fs);
    new_dir_path='';
    
    if traces_number > CHUNKS_LENGTH
       % dir containing all videos of CHUNKS_LENGTH number of images
       new_dir_path = strcat(num2str(traces_number),...
                '_traces_cwt-', num2str(fps),'_fps')
       mkdir(figs_path, new_dir_path);
    else
       CHUNKS_LENGTH = traces_number; % to always make the external loop
    end
     
     
    for  j = 1 : ceil(traces_number/CHUNKS_LENGTH) % ceil cauz it must loop for all 
                                  % k-th traces where k > j * CHUNKS_LENGTH
        max_iter = CHUNKS_LENGTH;
        
        % sets max_iter for last "set" of inner loops
        if max_iter * j > traces_number 
            max_iter = mod(traces_number, CHUNKS_LENGTH); 
        end
         
        % allocates for each ext loop the minimum number of frames
        F = struct('cdata', cell(1,max_iter), 'colormap', cell(1,max_iter));
        fig = figure;
        for i = 1 :  max_iter
           cur_trace = i + CHUNKS_LENGTH *(j-1);
           cwt(csvread(strcat(data_path, 'csvs', fs, 'DPAv2', fs, 'part0', fs,...
                                         'tr',num2str(cur_trace),'.csv')));
           title(strcat('Trace ',num2str(cur_trace)));
           F(i) = getframe(fig);                   % capture the i-th frame
        end
        % writing the video
        writerObj = VideoWriter(strcat(figs_path, new_dir_path, fs, num2str(traces_number),...
                '_traces_cwt-', num2str(fps),'_fps-',num2str(j),'.avi')); 
        writerObj.FrameRate = fps;
        open(writerObj);
        % 3GB to write video
        writeVideo(writerObj, F)
        % clean up
        close(writerObj)
        delete(fig);
        clear('writerObj', 'F', 'fig')
    end
return