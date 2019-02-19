function output =  get_the_best_dwt_params()

% output =  get_the_best_dwt_params()
% 
% Input:
%   []
% Output:
%   output - [WNAME, lev, THR_i, THR_METH_i, RESC_i]
%       
%       WNAME         - wavelet name = concat(family_name, N), N 
%                       vanishing moments
%       output(2:end) - check output(2:end) of get_best_dwt_params_for_wavelet.
% 
% It calculates all the best parameters of DWT decomposition for de-noising
% the signal nt. The result is an array of strings containing the
% parameters of wden to obtain the best approximation of t, given its 
% white-noised version nt. 
%         
    families = ["db", "sym", "coif", "fk", "bior", "rbio"];
    
    params = zeros(length(families), 6);
    
    for i = 1 : length(families)
        % [min_van_mom, min_MAE, l, thr, thr_meth, resc]
        params(i,:) = get_the_best_van_moment(families(i));
    end
    
    % min_MAE is in the params(:,2)    
    [min_v, best_family_i] = min(params(:,2));
    
    % pass the best params: 
    %   > build wavelet name family_string + string(min_van_mom)
    %   > return other params  
    output = [strcat(families(best_family_i), ...
                num2str(params(best_family_i,1))), ... 
                params(best_family_i,3 : end)];
    
return