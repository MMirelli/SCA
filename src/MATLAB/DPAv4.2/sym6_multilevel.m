%% Denoising by DWT using wavelet types in wtype and levels from 1 to max_l*3
load t1.mat % load trace 00

% max_l = floor(log2(legth(t(:,2)))); % Max level

max_l = 5; % arbitrary level

wtype = ["db4", "db6", "sym6"]; % wavelet types

for i = 1 : length(wtype)
    for j = 1 : 3 % when arbitrary max_l        
        %% Denoising till (max_l)-th level 
        td = zeros(5,length(t(:,2)));
        for level = 1 + max_l*(j-1):max_l*j
            td(level - max_l*(j- 1),:) = wden(t(:,2),'rigrsure','s','sln',level,wtype(i));
        end

        %% Printing by level an by wavelet types
        figure('Name', wtype(i)) % TODO find figures container
        for level = 1 + max_l*(j-1):max_l*j
            subplot(5,1,level - max_l*(j-1))
            plot(t(:,1),td(level - max_l*(j-1),:))
            title(sprintf('Level %i', level))
        end
    end
end