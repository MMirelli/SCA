function plot_denoised_signal(WNAME, LEV, THR_i, THR_METH_i, RESC_i)
   
% plot_denoised_signal(WNAME, LEV, THR_i, THR_METH_i, RESC_i)
% 
%   WNAME      - name of the wavelet used for denoising
%   LEV        - DWT level 
%   THR_i      - index of DWT thresholding type
%   THR_METH_i - index DWT thresholding method
%   RESC_i     - index rescaling method
% 
% This function plots three different figures
%   1. the initial signal (denoised) [t]
%   2. the DWT reconstruction [dt], of the white noised signal [nt]
%   3. t, nt and dt
% 
%   N.B.: dt is reconstructed using wden with the input parameters

    load 'data.mat';
    
    dt = wden(nt, TPTR_TYPES(THR_i), SORH(THR_METH_i), SCAL(RESC_i), LEV, WNAME);
    
    subplot(3,1,1); plot([t]); title('Original Signal');
    xlabel('Time (s)'); ylabel('Power (V)');
    
    subplot(3,1,2); plot([dt]); title( sprintf('%s Denoised Signal',...
        WNAME));
    xlabel('Time (s)'); ylabel('Power (V)');
    
    subplot(3,1,3); h1 = plot([nt t dt]);
    xlabel('Time (s)'); ylabel('Power (V)');
    
    h1(2).LineWidth = 2;
    h1(3).LineWidth = 2;
    legend('Noised Signal', 'Original Signal', sprintf('%s Denoised Signal', ...
        WNAME))
    title('Original, noised and denoised signals');

end