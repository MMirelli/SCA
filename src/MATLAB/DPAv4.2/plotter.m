%% wdenoise
% load t1.mat
% dt= wdenoise(t,10,'Wavelet','db3');%,...
% dt1 = wdenoise(t,15,'Wavelet','db3');%,...
% %     'DenoisingMethod','UniversalThreshold',...
% %     'ThresholdRule','Soft',...
% %     'NoiseEstimate','Levuntitled.elDependent');
% isequal(dt, t)
% isequal(dt, dt1)
% figure
% subplot(3,1,1)
% plot(t(:,1), t(:,2))
% axis tight
% title('Original Signal')
% subplot(3,1,2)
% plot(dt(:,1), dt(:,2))
% axis tight
% title('Denoised Signal')
% subplot(3,1,3)
% plot(dt1(:,1), dt1(:,2))
% axis tight
% title('Denoised Signal')
% 



%Copyright 2016 The MathWorks, Inc.
%% Load a signal
load t1.mat
% figure; 
% subplot(2,1,1); plot(f0); grid on; title('Original signal'); axis tight; 
% subplot(2,1,2); 
plot(t); 
% title('Original signal with noise'); 
% axis tight; grid on;
%%  Decompose signal using Discrete Wavelet Transform  
dwtmode('per','nodisplay');
wname = 'sym6';
level = 5;
[C, L] = wavedec(t(:,2),level,wn
[C, L] = wavedec(t(:,2),level,wname);
plotDetCoefHelper(t(:,2),C,L); %helperFunction to plot the coefficients at every levelame);
plotDetCoefHelper(t(:,2),C,L); %helperFunction to plot the coefficients at every level
%% Analyze the subbands and determine the threshold
%% Denoise the signal 
fd = wden(f,'rigrsure','s','sln',level,wname);
figure; 
subplot(2,1,1); 
plot(f);axis tight; grid on;title('Noisy Signal');
subplot(2,1,2)
plot(fd); axis tight; grid on;
title(sprintf('Denoised Signal SNR:  %0.2f dB',-20*log10(norm(abs(f0-fd))/norm(f0))));
%% Comparing with other techniques
figure; 
subplot(2,2,1); 
plot(f);axis tight; grid on;title('Noisy Signal');
subplot(2,2,2)
plot(fd); axis tight; grid on;
title(sprintf('Wavelet Denoising SNR:  %0.2f dB',-20*log10(norm(abs(f0-fd))/norm(f0))));
subplot(2,2,3)
fsg = sgolayfilt(f,31,101);
plot(fsg); axis tight; grid on;
title(sprintf('Savitzky Golay SNR:  %0.2f dB',-20*log10(norm(abs(f0-fsg))/norm(f0))));
subplot(2,2,4)
movavg = 1/20*ones(20,1);
fmv = filtfilt(movavg,1,f);
plot(fmv); axis tight; grid on;
title(sprintf('Moving Average SNR:  %0.2f dB',-20*log10(norm(abs(f0-fmv))/norm(f0))));
