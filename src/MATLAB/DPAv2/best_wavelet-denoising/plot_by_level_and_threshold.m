function ax =  plot_by_level_and_threshold(input)

% ax = plot_by_level_and_threshold (input)
% input - string array
%           ["W_NAME", "THR_METH_i", "RESC_i"]
% Input:
%   W_NAME    -  name of the wavelet we want to plot the MAE with respect 
%                to the initial denoised signal. This must be the full 
%                wavelet name:             
%                           wavelet_family.N, 
%                with N number of vanishing moments, if necessary;
%   
%   THR_METH_i - index of thresholding method employed in DWT, fixed 
%                parameter among the following:
%                           ["s","h"];
%   RESC_i     - index of rescaling method employed in DWT, fixed 
%                parameter among the following:
%                           ["sln", "mln","one"].
% Ouput:
%   ax         - axes of the plot.
% 
% It plots the MAE of the DWT reconstruction (dt) of the noised signal (nt)
% having as variables the type of thresholding(["rigrsure","heursure",
% "sqtwolog","minimaxi"]) and the level ([1 : max_lev]) of the DWT.
% 
% 

    load data.mat;
    
    if ~isstring(input) || length(input) ~= 3
        perror('Input type not correct: please pass a string array ',...
            'with this format: ["W_NAME", "THR_METH_i", "RESC_i"]');
    end
    
    num_input = arrayfun(@(x) str2num(x), (input(2:end)));
            
    MAX_L = floor(log2(length(t(:,1)))); % Max level
    THR_NUMBER = 4;
    Z = zeros(MAX_L, THR_NUMBER);

    % get the MAE per level
    for l = 1 : MAX_L
        for thr_i = 1 : THR_NUMBER
            dt = wden(nt, TPTR_TYPES(thr_i), SORH(num_input(1)),...
                SCAL(num_input(2)), l, input(1));
            
            Z(l, thr_i) = sum(abs(t-dt))/length(t);
        end
    end
    [X,Y] = meshgrid(1:THR_NUMBER, 1:MAX_L);
    surf(X,Y,Z,'FaceAlpha',0.5);
    xlabel('Threshold types ["rigrsure","heursure","sqtwolog","minimaxi"]');
    ylabel('Levels');
    zlabel('MAE');
    ax = gca;
return
