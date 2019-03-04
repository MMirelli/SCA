function [] = print_rand_trace_and_cwt(traces_path, n_traces, groupsize)
% 
% [] = print_rand_trace_and_cwt(traces_path)
% 
% It prints a csv-trace picked randomly among those stored in traces_path.
% 
% 
    Imax = length(dir(strcat(traces_path, '*.csv')));
    r = randi(Imax);
    trace_name = strcat('tr', num2str(r));
    trace = csvread(strcat(traces_path, trace_name, '.csv'));
    
    
    
    tmp_fold_name = 'fig-tmp';
    if ~exist(tmp_fold_name, 'dir')
       mkdir(tmp_fold_name);
       fprintf('%s created...\n', tmp_fold_name);
    end
       
    fig_tr = figure(1);
    plot(trace);
    trace_full_path = strcat(tmp_fold_name, filesep, trace_name);
    savefig(fig_tr, trace_full_path);
    
    fig_cwt = figure(2);
    cwt(trace);
    cwt_name = strcat('cwt-', trace_name);
    cwt_full_path = strcat(tmp_fold_name, filesep, cwt_name);
    savefig(fig_cwt, cwt_full_path);    
    
    close(fig_tr, fig_cwt);
    
    sub1=hgload(strcat(trace_full_path,'.fig'));
    sub2=hgload(strcat(cwt_full_path,'.fig'));
    
    figs_path = strrep(traces_path, 'processed', 'figs');
    
    loading_filename = strcat(figs_path, 'plot_', num2str(n_traces), ...
        '_rand_traces'); 
    
    if nargin == 3
       loading_filename = strcat(loading_filename, ...
           '-group_size',num2str(groupsize));
    end
    
    loading_filename = strcat(loading_filename, '.mat');
    
    load(loading_filename, 'fig'); 
    sub3 = fig;
        
    % Prepare subplots
    ret_fig = figure(4);
             
   
    h(1)=subplot(3,1,1);
    h(2)=subplot(3,1,2);
    h(3)=subplot(3,1,3);
    

    % Paste figures on the subplots
    copyobj(allchild(get(sub2,'CurrentAxes')),h(1));
    fprintf('Subplotting %s\n', trace_name);
    copyobj(allchild(get(sub3,'CurrentAxes')),h(2));
    fprintf('Subplotting %s\n', cwt_name);
    copyobj(allchild(get(sub1,'CurrentAxes')),h(3));
%     fprintf('Subplotting %i random traces in %i group size\n', n_traces, groupsize);
    
    ret_fig_name = strcat('rand_trace', num2str(r), '_cwt-', ...
        num2str(n_traces));
    
    if nargin == 3
        ret_fig_name = strcat(ret_fig_name, '-', num2str(groupsize));
    end
    
    ret_file = strcat(figs_path, ret_fig_name,'.mat');
    save(ret_file, 'ret_fig', '-v7.3');
    close(sub1, sub2, sub3);
    
    rmdir(tmp_fold_name, 's');
    fprintf('%s removed...\n', tmp_fold_name);
    fprintf('File %s saved.\nOpen it running:\nload %s\n', ret_fig_name, ret_file);
    
    clear
end