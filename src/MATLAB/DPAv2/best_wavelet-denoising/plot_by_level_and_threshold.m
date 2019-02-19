function ax =  plot_by_level_and_threshold(W_NAME, T_M_I, S_I)

% ax = plot_by_level_and_threshold (W_NAME, THR_METH, SCAL)
% 
% Input:
%   W_NAME - name of the wavelet we want to plot the MAE with respect to the
%            initial denoised signal. This must be the full wavelet name:
%                       wavelet_family.N, 
%           with N number of vanishing moments, if necessary;
%   
%   T_M_I  - index of thresholding method employed in DWT, fixed parameter 
%            among the following:
%                           ["s","h"];
%   S_I    - index of rescaling method employed in DWT, fixed parameter among
%            the following:
%                           ["sln", "mln","one"].
% Ouput:
%   ax     - axes of the plot.
% 
% It plots the MAE of the DWT reconstruction (dt) of the noised signal (nt)
% having as variables the type of thresholding(["rigrsure","heursure",
% "sqtwolog","minimaxi"]) and the level ([1 : max_lev]) of the DWT.
% 
% 

    load data.mat;
    
    if(isstring(T_M_I))
       T_M_I = str2num(T_M_I) ;
    end
    
    if(isstring(S_I))
        S_I = str2num(S_I);  
    end
    
    MAX_L = floor(log2(length(t(:,1)))); % Max level
    THR_NUMBER = 4;
    Z = zeros(MAX_L, THR_NUMBER);

    % get the MAE per level
    for l = 1 : MAX_L
        for thr_i = 1 : THR_NUMBER
            dt = wden(nt, TPTR_TYPES(thr_i), SORH(T_M_I), SCAL(S_I), l, ...
                    W_NAME);
            
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
