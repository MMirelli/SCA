function output = get_the_best_van_moment(W_FAMILY)
% output = get_the_best_best_van_moment(W_FAMILY)
% 
% Input:
%   W_FAMILY - id as string of wavelet family supported by wden. One of the
%              following:
%                   ['db', 'sym', 'coif', 'fk', 'bior', 'rboi'].
% 
% Output:
%   output - [min_van_mom, min_MAE, lev, THR_i, THR_METH_i, RESC_i]
% 
%       min_van_mom   - vanishing moment minimizing MAE for the current
%                       wavelet family;
%       output(2:end) - check output of get_best_dwt_param.    
% 
% It calculates the best number of vanishing moments for a specific wavelet
% family, in order to de-noise the signal nt using DWT decomposition.
% 
    switch W_FAMILY % selecting the vanishing moments
        case 'db'          
            van_moms = 1:45;
        case 'sym'
            van_moms = 2:27; % [2:45], do it till 45 if possible
        case 'coif'
            van_moms = 1:5;
        case 'fk'
            van_moms = [4,6,8,14,18,22];
        case 'bior' 
            van_moms = [1.1, 1.3, 1.5, 2.2, 2.4, 2.6, 2.8, 3.1, 3.3, 3.5, ...
                 3.7, 3.9, 4.4, 5.5, 6.8];
        case 'rbio'
            van_moms = [1.1, 1.3, 1.5, 2.2, 2.4, 2.6, 2.8, 3.1, 3.3, 3.5, ...
                 3.7, 3.9, 4.4, 5.5, 6.8];
        otherwise
            perror('Unknown wavelet');
    end
    
    % params is a matrix having a row per vanishing moment
    params = zeros(length(van_moms), 5);
    
    for i = 1 : length(van_moms)
       fprintf('Best params for wavelet %s have been processed.\n', ... 
            strcat(W_FAMILY, num2str(van_moms(i))));
       % each row represents the best DWT parameters per vanishing moment
       params(i,:) = get_best_dwt_params_for_wavelet(strcat(W_FAMILY,... 
            num2str(van_moms(i))));
    end
    
    [min_v, min_row] = min(params(:,1));
    output = [van_moms(min_row), params(min_row, :)];
    
return