function [] = averager(n, group_size, traces_path)

    FS = filesep;
    if traces_path(end) ~= FS, traces_path = strcat(traces_path,FS); end

    rp = randperm(length(dir(strcat(traces_path,'*.csv'))), n);
    
    fig = figure; 
    group = zeros(3253, 10);
    for j = 0 : group_size : n - 1
        fprintf('Calculating avg of:\n');
        for i = j+1 : j + group_size
           cur_tr_name = strcat('tr', num2str(rp(i)), '.csv');
           cur_tr = csvread(strcat(traces_path, cur_tr_name));
           
           group(:,i) = cur_tr;
           
           fprintf(' %s ', cur_tr_name(1:end-4));
        end
       fprintf('\n');
       fprintf('Printing the avg of the group number %i\n', floor((j+1)/group_size));
       average = mean(group,2);
       
       plot(average);
       hold on;
       grid('on');
       grid minor;
    end
   
    figs_path = strrep(traces_path, 'processed', 'figs');
    img_full_name = strcat(figs_path, 'plot_', num2str(n), '_rand_traces-group_size',num2str(group_size));
%   saves image as .mat since for 100k traces it takes more than 2GB)
    save(strcat(img_full_name,'.mat'), 'fig', '-v7.3');
    delete(fig);
    
    fprintf('The image has been correctly saved. \n View it typing:\n load %s\n', img_full_name);
    fprintf('Terminating.\n');
    
return