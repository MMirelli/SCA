function [] = plot_rand_traces(n, sub_plots_n, traces_path)

% 
% mod(n, subplots) = 0, otherwise the behaviour might be incorrect
% 
% 

    FS = filesep;
    UPDIR = strcat('..', FS);
    DATA_PATH = strcat(UPDIR, UPDIR, 'data', FS);
    
    if traces_path(end) ~= FS, traces_path = strcat(traces_path,FS); end

    rp = randperm(length(dir(traces_path)), n);
    
    if n <= 100
        labels = strings(1,n);
        axes = gobjects(1,n);
    end
    % traces per subplot     
    tr_subplot = n/sub_plots_n;
    figure; 
    for j = 0 : tr_subplot : n - 1
                 
        subplot(sub_plots_n, 1, j/tr_subplot + 1);
        for i = j+1 : j + tr_subplot
           cur_tr_name = strcat('tr', num2str(rp(i)), '.csv');
           cur_tr = csvread(strcat(traces_path, cur_tr_name));
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
end