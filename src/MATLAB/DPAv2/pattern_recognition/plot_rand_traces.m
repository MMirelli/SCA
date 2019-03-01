function [] = plot_rand_traces(n, sub_plots_n, traces_path)

% 
% mod(n, subplots) = 0, otherwise the behaviour might be incorrect
% 
% 
    FS = filesep;
    if traces_path(end) ~= FS, traces_path = strcat(traces_path,FS); end

    rp = randperm(length(dir(strcat(traces_path,'*.csv'))), n);
    
    if n <= 100
        labels = strings(1,n);
        axes = gobjects(1,n);
    end
    % traces per subplot     
    tr_subplot = n/sub_plots_n;
    fig = figure; 
    for j = 0 : tr_subplot : n - 1
                 
        subplot(sub_plots_n, 1, j/tr_subplot + 1);
        for i = j+1 : j + tr_subplot
           cur_tr_name = strcat('tr', num2str(rp(i)), '.csv');
           cur_tr = csvread(strcat(traces_path, cur_tr_name));
           fprintf('Plotting trace %s ...\n', cur_tr_name(1:end-4));
           if n <= 100
               axes(i) = plot(cur_tr);
               labels(i) = cur_tr_name(1:end-4);
            else
                plot(cur_tr);
            end
           hold on;
        end 
       grid('on');
       grid minor;
    end
   if n <= 100 % otherwise the legend would be too large
        legend(axes, labels);
   end
   
    figs_path = strrep(traces_path, 'processed', 'figs');
    img_full_name = strcat(figs_path, 'plot_', num2str(n), '_rand_traces');
%   saves image as .mat since for 100k traces it takes more than 2GB)
    save(strcat(img_full_name,'.mat'), 'fig', '-v7.3');
    delete(fig);
    
    fprintf('The image has been correctly saved. \n View it typing:\n load %s\n', img_full_name);
    fprintf('Terminating.\n');
    
end