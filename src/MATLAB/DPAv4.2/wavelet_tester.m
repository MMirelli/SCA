load t1.mat

level = 5;

sym6 = wden(t(:,2),'rigrsure','s','sln',level,'sym6');
db3 = wden(t(:,2), 'rigrsure','s','sln',level,'db3');
db6 = wden(t(:,2), 'rigrsure','s','sln',level,'db6');
sym4 = wdenoise(t(:,2),level);
def = wdenoise(t(:,2));


wdenoise(t,15,'Wavelet','db3');%,...
% %     'DenoisingMethod','UniversalThreshold',...
% %     'ThresholdRule','Soft',...
% %     'NoiseEstimate','Levuntitled.elDependent');

figure; 
subplot(6,1,1); plot(t); title('noisy');
subplot(6,1,2); plot(sym6); title('Denoised by symlet6');
subplot(6,1,3); plot(db3); title('Denoised by daubechies3');
subplot(6,1,4); plot(db6); title('Denoised by daubechies6');
subplot(6,1,5); plot(sym4); title('Denoised by symlet4');
subplot(6,1,6); plot(def); title('Denoised by def');

% 
% sym_db = abs(sym6 - db3);
% db_bay = abs(db3 - sym4);
% sym_bay = abs(sym6 - sym4);
% 
% figure;
% subplot(3,1,1); plot(sym_db); title('|sym-db|');
% subplot(3,1,2); plot(db_bay); title('|db-bay|');
% subplot(3,1,3); plot(sym_bay); title('|sym - bay|');
