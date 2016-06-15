
%% Florence,launch classif
clear all
close all
clc

addpath('LDMLT_TS')
%Load the data from the folder
master_path = 'C:\Ira\Data_Master\Florence\'
outpath = 'C:\Ira\Results_Master\Florence\';
mkdir(outpath);
%Position
folders_path = strcat(master_path,'Position Data\35\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
%training params
 tripletsfactor = 20; % era 20
 cycle = 1;
 alphafactor = 5;% era 5;
for i = 1:size(nameFolds,1)
    outdir = strcat(outpath,'Position Data\35\');
    mkdir(outdir);
    in_path = strcat(folders_path,nameFolds{i},'\train_test_data\');
    function_Florence_LDMLTS_classif_and_save( in_path , outpath,tripletsfactor,cycle,alphafactor);

end

%Temporal Modeling
 folders_path1 = strcat(master_path,'Modeling\');

%baseline removal
folders_path = strcat(folders_path1,'Baseline Removal and Rescaling\35\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i = 1:size(nameFolds,1)
    outdir = strcat(outpath,'Modeling\Baseline Removal and Rescaling\35\');
    mkdir(outdir);
    in_path = strcat(folders_path,nameFolds{i},'\train_test_data\');
	function_Florence_LDMLTS_classif_and_save( in_path , outpath,tripletsfactor,cycle,alphafactor);

end

%Dynamic Movement Primitives
folders_path = strcat(folders_path1,'Dynamic Movement Primitives\35\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];

for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\')
    outdir = strcat(outpath,'Modeling\DMP\35\',nameFolds{i},'\');
    mkdir(outdir);
    d2 = dir(in_path);
    isub = [d2(:).isdir]; %# returns logical vector
    nameFolds2 = {d2(isub).name}';
    nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
    for j=1:size(nameFolds2,1)
        final_in_path = strcat(in_path,nameFolds2{j},'\train_test_data\');
        function_Florence_LDMLTS_classif_and_save( final_in_path , outpath,tripletsfactor,cycle,alphafactor);
    end
end

%Fourier Decomposition
folders_path = strcat(folders_path1,'Fourier Decomposition\35\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\')
    outdir = strcat(outpath,'Modeling\Fourier\35\',nameFolds{i},'\');
    mkdir(outdir);
    d2 = dir(in_path);
    isub = [d2(:).isdir]; %# returns logical vector
    nameFolds2 = {d2(isub).name}';
    nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
    for j=1:size(nameFolds2,1)
        final_in_path = strcat(in_path,nameFolds2{j},'\train_test_data\');
        function_Florence_LDMLTS_classif_and_save( final_in_path , outpath,tripletsfactor,cycle,alphafactor);
    end
end

%Piecewise Aggregate Approximation\35\
folders_path = strcat(folders_path1,'Piecewise Aggregate Approximation\35\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\')
    outdir = strcat(outpath,'Modeling\PAA\35\',nameFolds{i},'\');
    mkdir(outdir);
    d2 = dir(in_path);
    isub = [d2(:).isdir]; %# returns logical vector
    nameFolds2 = {d2(isub).name}';
    nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
    for j=10:size(nameFolds2,1)
        final_in_path = strcat(in_path,nameFolds2{j},'\train_test_data\')
        function_Florence_LDMLTS_classif_and_save( final_in_path , outpath,tripletsfactor,cycle,alphafactor);
    end
end

%Symbolic Aggregate Approximation\35\
folders_path = strcat(folders_path1,'Symbolic Aggregate Approximation\35\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\')
    outdir = strcat(outpath,'Modeling\SAX\35\',nameFolds{i},'\');
    mkdir(outdir);
    d2 = dir(in_path);
    isub = [d2(:).isdir]; %# returns logical vector
    nameFolds2 = {d2(isub).name}';
    nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
    for j=1:size(nameFolds2,1)
        final_in_path = strcat(in_path,nameFolds2{j},'\train_test_data\')
        function_Florence_LDMLTS_classif_and_save( final_in_path , outpath,tripletsfactor,cycle,alphafactor);
    end
end