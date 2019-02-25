% To set the path to your folder follow the steps
%   >> pwd
%   >> path_to_local_folder = 'your_path_to_SCA'
%   >> save .path_to_SCA.mat

p=pwd;
% Checks if the MATLAB environment has been set correctly; if not it sets
% the path
if ~strcmp(p(end-9:end), 'src\MATLAB')
    file_mat = strcat(pwd, filesep, '.path_to_SCA.mat');
    load(file_mat)
    my_dir = strcat(path_to_local_folder,'src', filesep, 'MATLAB', filesep);
    cd(my_dir)
end
files = dir;
files(1:2) = []; % removing . ../
dirFlags = [files.isdir];
subfolders = files(dirFlags);
% adds all current subfolders
for i = 1 : length(subfolders)
    addpath(genpath(subfolders(i).name))
end
clear;
