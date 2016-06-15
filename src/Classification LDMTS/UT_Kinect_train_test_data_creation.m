%% Ut-Kinect, create train_test_sets
clear all
close all
clc

%Load the data from the folder
master_path = 'C:\Ira\Data_Master\UT_Kinect\'

%Position
folders_path = strcat(master_path,'Position Data\74\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\');
    function_UT_train_test_data_creation( in_path );

end

%Temporal Modeling
folders_path1 = strcat(master_path,'Modeling\');

%baseline removal
folders_path = strcat(folders_path1,'Baseline Removal and Rescaling\74\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\');
	function_UT_train_test_data_creation( in_path );

end

%Dynamic Movement Primitives
folders_path = strcat(folders_path1,'Dynamic Movement Primitives\74\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\')
    d2 = dir(in_path);
    isub = [d2(:).isdir]; %# returns logical vector
    nameFolds2 = {d2(isub).name}';
    nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
    for j=1:size(nameFolds2,1)
        final_in_path = strcat(in_path,nameFolds2{j},'\');
        function_UT_train_test_data_creation( final_in_path );
    end
end

%Fourier Decomposition
folders_path = strcat(folders_path1,'Fourier Decomposition\74\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\')
    d2 = dir(in_path);
    isub = [d2(:).isdir]; %# returns logical vector
    nameFolds2 = {d2(isub).name}';
    nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
    for j=1:size(nameFolds2,1)
        final_in_path = strcat(in_path,nameFolds2{j},'\');
        function_UT_train_test_data_creation( final_in_path );
    end
end

%Piecewise Aggregate Approximation\74\
folders_path = strcat(folders_path1,'Piecewise Aggregate Approximation\74\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\')
    d2 = dir(in_path);
    isub = [d2(:).isdir]; %# returns logical vector
    nameFolds2 = {d2(isub).name}';
    nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
    for j=1:size(nameFolds2,1)
        final_in_path = strcat(in_path,nameFolds2{j},'\')
        function_UT_train_test_data_creation( final_in_path );
    end
end

%Symbolic Aggregate Approximation\74\
folders_path = strcat(folders_path1,'Symbolic Aggregate Approximation\74\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\')
    d2 = dir(in_path);
    isub = [d2(:).isdir]; %# returns logical vector
    nameFolds2 = {d2(isub).name}';
    nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
    for j=1:size(nameFolds2,1)
        final_in_path = strcat(in_path,nameFolds2{j},'\')
        function_UT_train_test_data_creation( final_in_path );
    end
end
