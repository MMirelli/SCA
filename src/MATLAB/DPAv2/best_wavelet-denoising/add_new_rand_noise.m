
function [] = add_new_rand_noise(csv_trace_file)

% [] = add_new_rand_noise(csv_trace_file)
% 
% Input:
%   csv_trace_file - string representing either the absolute or the
%                    relative path to the *csv* trace.
% 
% It executes the following:
%   > clears the workspace;
%   > reads the trace (csv_trace_file) from the folder;
%   > saves data.mat containing useful datastructs.  
    
    % gets the original (denoised) trace
    t = csvread(csv_trace_file);

    % nt is the initial signal with white gaussian noise added
    nt = awgn(t,10E-10000,75);

    % arrays necessary for later computations
    TPTR_TYPES = ["rigrsure","heursure","sqtwolog","minimaxi"];
    SORH = ["s","h"];
    SCAL = ["sln", "mln","one"];

    save('data.mat');

end