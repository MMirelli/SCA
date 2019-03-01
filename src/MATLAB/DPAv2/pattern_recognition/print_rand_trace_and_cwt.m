function [] = print_rand_trace_and_cwt(traces_path, n_traces, groupsize)
% 
% [] = print_rand_trace_and_cwt(traces_path)
% 
% It prints a csv-trace picked randomly among those stored in traces_path.
% 
% 
    
    r = randi(length(dir(traces_path)));
    trace_name = strcat('tr', r);
    trace = csvread(strcat(traces_path, trace_name, '.csv'));
    
    tmp_fold_name = 'fig-tmp';
    if ~exist(tmp_fold_name, 'dir')
       mkdir(tmp_fold_name);
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
        
    sub1=hgload(strcat(trace_full_path,'.fig'));
    sub2=hgload(strcat(cwt_full_path,'.fig'));
    
    % Prepare subplots
    ret_fig = figure(3);
    figs_path = strrep(traces_path, 'processed', 'figs');
    
    if ~exist('n_traces','var')
        h(1)=subplot(1,2,1);
        h(2)=subplot(1,2,2);
    else
        load(strcat(figs_path, 'plot_', num2str(n_traces), ...
            '_rand_traces-group_size',num2str(groupsize),'.mat'));    
        % plot_rand_traces fig         
        sub3 = fig;
        
        h(1)=subplot(1,3,1);
        h(2)=subplot(1,3,2);
        h(3)=subplot(1,3,3);
        
    end
    % Paste figures on the subplots
    copyobj(allchild(get(sub1,'CurrentAxes')),h(1));
    copyobj(allchild(get(sub2,'CurrentAxes')),h(2));
    
    % Add legends
    l(1)=legend(h(1),'LegendForFirstFigure')
    l(2)=legend(h(2),'LegendForSecondFigure')
    
    ret_fig_name = strcat('rand_trace', num2str(r), '_cwt');
    
    if exist('n_traces','var')
        copyobj(allchild(get(sub3,'CurrentAxes')),h(3));
        l(3)=legend(h(3),'LegendForSecondFigure')
    
        ret_fig_name = strcat(ret_fig_name, '-', num2str(n_traces), '-', num2str(groupsize));
    end
   
    save(strcat(figs_path, ret_fig_name,'.mat'), 'fig', '-v7.3');
    delete(fig_tr, fig_cwt, ret_fig);
    clear
end