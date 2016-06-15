%% Ut-Kinect, create train_test_sets
clear all
close all
clc

%Load the data from the folder
master_path = 'C:\Ira\Data_Master\MSRAction3D\'




%Position
folders_path = strcat(master_path,'Position Data\76\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\');
     function_AS1MSR_train_test_data_creation( in_path );
     function_AS2MSR_train_test_data_creation( in_path );
    function_AS3MSR_train_test_data_creation( in_path );

end

%Temporal Modeling
folders_path1 = strcat(master_path,'Modeling\');

%baseline removal
folders_path = strcat(folders_path1,'Baseline Removal and Rescaling\76\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\');
	function_AS1MSR_train_test_data_creation( in_path );
    function_AS2MSR_train_test_data_creation( in_path );
    function_AS3MSR_train_test_data_creation( in_path );

end

%Dynamic Movement Primitives
folders_path = strcat(folders_path1,'Dynamic Movement Primitives\76\');
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
        function_AS1MSR_train_test_data_creation( final_in_path );
        function_AS2MSR_train_test_data_creation( final_in_path );
        function_AS3MSR_train_test_data_creation( final_in_path );
    end
end

%Fourier Decomposition
folders_path = strcat(folders_path1,'Fourier Decomposition\76\');
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
        function_AS1MSR_train_test_data_creation( final_in_path );
        function_AS2MSR_train_test_data_creation( final_in_path );
        function_AS3MSR_train_test_data_creation( final_in_path );
    end
end

%Piecewise Aggregate Approximation\76\
folders_path = strcat(folders_path1,'Piecewise Aggregate Approximation\76\');
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
        function_AS1MSR_train_test_data_creation( final_in_path );
        function_AS2MSR_train_test_data_creation( final_in_path );
        function_AS3MSR_train_test_data_creation( final_in_path );
    end
end

%Symbolic Aggregate Approximation\76\
folders_path = strcat(folders_path1,'Symbolic Aggregate Approximation\76\');
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
        function_AS1MSR_train_test_data_creation( final_in_path );
        function_AS2MSR_train_test_data_creation( final_in_path );
        function_AS3MSR_train_test_data_creation( final_in_path );
    end
end
