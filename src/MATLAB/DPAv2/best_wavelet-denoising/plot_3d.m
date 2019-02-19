% Plots the MAE of wden(nt) letting vary the decomposition level and
% threshold type; other parameters have been calculated by 
% get_the_best_dwt_params and loaded in best_DWT_param.mat.

load best_DWT_param.mat;

plot_by_level_and_threshold(best(1,1),best(1,3),best(1,4))