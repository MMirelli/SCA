
function output = get_best_dwt_params_for_wavelet(WAVELET)

% output = get_best_dwt_param(WAVELET)
% 
% Input:
%       WAVELET - choose among 'dbN', 'fkN', 'coifN', 'symN','biorN.M' 
%                 or 'rbioN.M', with N, M indicating number of vanishing 
%                 moments.
% Output:
%   output - [min_MAE, i, j, k, l]
%       min_MAE - minimum Mean Absolute Error (MAE) of original signal over 
%                 the one denoised by the selected wavelet;
% 
%       i       - best DWT level 
%                       levels: [1, 2, ..., floor(log2(n))], 
%                    where n: number of samples in the original signal;
% 
%       j       - index of best thresholding among the following, in 
%                 this order: 
%           TPTR_TYPES=["rigrsure","heursure","sqtwolog","minimaxi"];
% 
%       k       - index of best thresholding method, either "soft" 
%                 or "hard":
%                       SORH = ["s","h"];
%
%       l       - index of best rescaling among:
%                       SCAL = ["sln", "mln","one"];
%
% It calculates the best DWT params for a specific wavelet WNAME.N, with N
% vanishing moment. The metrics chosen to compare the denoised signals is 
% the Mean Absolute Error (MAE).
% 
    load data.mat;

    max_l = floor(log2(length(t(:,1)))); % Max level

    rst = zeros(max_l, length(TPTR_TYPES), length(SORH), length(SCAL));

    % get the metrics per level
    for l_i = 1 : max_l
        % // // // // // threshold
        for tptr_i = 1 : length(TPTR_TYPES)
            % // // // // // threshold method (soft/hard)
            for sorh_i = 1 : length(SORH)
                % // // // // // rescaling
                for scal_i = 1 : length(SCAL)
                    
                    dt = wden(nt, TPTR_TYPES(tptr_i), SORH(sorh_i),...
                        SCAL(scal_i), l_i, WAVELET);
                    
                    rst(l_i, tptr_i, sorh_i, scal_i) = ...
                                    sum(abs(t-dt))/length(t);
                end
            end
        end
    end

    % find the DWT parameters so to minimize MAE
    [min_MAE, position] = min(rst(:));
    [i,j,k,l] = ind2sub(size(rst),position);
    output = [min_MAE, i, j, k, l];
return

