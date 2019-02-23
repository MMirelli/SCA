% To set the path to your folder follow the steps
%   > pwd
%   > path_to_local_folder = 'your_path_to_SCA'
%   > save .path_to_SCA.mat

file_s = strcat(pwd, filesep, '.path_to_SCA.mat');
load(file_s)
my_dir = strcat(path_to_local_folder,'in_progress/src/MATLAB/');
cd(my_dir)

files = dir;
files(1:2) = []; % removing . ../
dirFlags = [files.isdir];
subfolders = files(dirFlags);
% adds all current subfolders
for i = 1 : length(subfolders)
    addpath(genpath(subfolders(i).name))
end
clear;
