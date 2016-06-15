
% UT Kinect launch classif

%% Ut-Kinect
clear all
close all
clc

addpath('LDMLT_TS');
%Load the data from the folder
master_path = 'C:\Ira\Data_Master\UT_Kinect\'
outpath = 'C:\Ira\Results_Master\UT_Kinect\';
mkdir(outpath);
% Position
folders_path = strcat(master_path,'Position Data\74\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
%training params
  tripletsfactor = 20; % era 20
  cycle = 1;
  alphafactor = 5;% era 5;
  outdir = strcat(outpath,'Position Data\74\');
    mkdir(outdir);
%     txt_resumen = strcat(outdir,'Fscores.txt')
%     fid = fopen(txt_resumen,'a+');
%     Mat_scores = [];
% for i = 1:size(nameFolds,1)
%     
%     in_path = strcat(folders_path,nameFolds{i},'\train_test_data\');
%     F = function_UT_LDMLTS_classif_and_save( in_path , outpath,tripletsfactor,cycle,alphafactor);
%     path_name =  strcat(nameFolds{i}, ' _ ', num2str(F),'\n');
%     fprintf(fid, path_name);
%     Mat_scores = [Mat_scores;F];
% end
% 
% save(strcat(outdir,'Fscores.mat'),'Mat_scores');
% [max, pos]= max(Mat_scores);
% fprintf(fid,'F max %f position in file %d',max,pos);
% fclose(fid);
% Temporal Modeling
 folders_path1 = strcat(master_path,'Modeling\');

%baseline removal
folders_path = strcat(folders_path1,'Baseline Removal and Rescaling\74\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
outdir = strcat(outpath,'Modeling\Baseline Removal and Rescaling\74\');
    mkdir(outdir);
    txt_resumen = strcat(outdir,'Fscores.txt')
    fid = fopen(txt_resumen,'a+');
    Mat_scores = [];
for i = 1:size(nameFolds,1)
    
    in_path = strcat(folders_path,nameFolds{i},'\train_test_data\');
	F = function_UT_LDMLTS_classif_and_save( in_path , outpath,tripletsfactor,cycle,alphafactor);
    path_name =  strcat(nameFolds{i}, ' _ ', num2str(F),'\n');
    fprintf(fid, path_name);
    Mat_scores = [Mat_scores;F];
end

save(strcat(outdir,'Fscores.mat'),'Mat_scores');
[max, pos]= max(Mat_scores);
fprintf(fid,'F max %f position in file %d',max,pos);
fclose(fid);

%Dynamic Movement Primitives
folders_path = strcat(folders_path1,'Dynamic Movement Primitives\74\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];

for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\')
    outdir = strcat(outpath,'Modeling\DMP\74\',nameFolds{i},'\');
    mkdir(outdir);
    mkdir(outdir);
    txt_resumen = strcat(outdir,'Fscores.txt')
    fid = fopen(txt_resumen,'a+');
    d2 = dir(in_path);
    isub = [d2(:).isdir]; %# returns logical vector
    nameFolds2 = {d2(isub).name}';
    nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
    Mat_scores = [];
    for j=1:size(nameFolds2,1)
        final_in_path = strcat(in_path,nameFolds2{j},'\train_test_data\');
        F = function_UT_LDMLTS_classif_and_save( final_in_path , outpath,tripletsfactor,cycle,alphafactor);
        path_name =  strcat(nameFolds2{j}, ' _ ', num2str(F),'\n');
        fprintf(fid, path_name);
        Mat_scores = [Mat_scores;F];
    end

    save(strcat(outdir,'Fscores.mat'),'Mat_scores');
%     [max, pos]= max(Mat_scores);
%     fprintf(fid,'F max %f position in file %d',max,pos);
     fclose(fid);
end

% Fourier Decomposition
folders_path = strcat(folders_path1,'Fourier Decomposition\74\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\')
    outdir = strcat(outpath,'Modeling\Fourier\74\',nameFolds{i},'\');
    mkdir(outdir);
    txt_resumen = strcat(outdir,'Fscores.txt')
    fid = fopen(txt_resumen,'a+');
    d2 = dir(in_path);
    isub = [d2(:).isdir]; %# returns logical vector
    nameFolds2 = {d2(isub).name}';
    nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
    Mat_scores = [];
    for j=1:size(nameFolds2,1)
        final_in_path = strcat(in_path,nameFolds2{j},'\train_test_data\');
        F = function_UT_LDMLTS_classif_and_save( final_in_path , outpath,tripletsfactor,cycle,alphafactor);
    	path_name =  strcat(nameFolds2{j}, ' _ ', num2str(F),'\n');
        fprintf(fid, path_name);
        Mat_scores = [Mat_scores;F];
end

save(strcat(outdir,'Fscores.mat'),'Mat_scores');
% [max, pos]= max(Mat_scores);
% fprintf(fid,'F max %f position in file %d',max,pos);
fclose(fid);
end

% Piecewise Aggregate Approximation\74\
folders_path = strcat(folders_path1,'Piecewise Aggregate Approximation\74\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\')
    outdir = strcat(outpath,'Modeling\PAA\74\',nameFolds{i},'\');
    mkdir(outdir);
    txt_resumen = strcat(outdir,'Fscores.txt')
    fid = fopen(txt_resumen,'a+');
    d2 = dir(in_path);
    isub = [d2(:).isdir]; %# returns logical vector
    nameFolds2 = {d2(isub).name}';
    nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
    Mat_scores = [];
    for j=1:size(nameFolds2,1)
        final_in_path = strcat(in_path,nameFolds2{j},'\train_test_data\')
        F = function_UT_LDMLTS_classif_and_save( final_in_path , outpath,tripletsfactor,cycle,alphafactor);
     	path_name =  strcat(nameFolds2{j}, ' _ ', num2str(F),'\n');
        fprintf(fid, path_name);
        Mat_scores = [Mat_scores;F];
end

save(strcat(outdir,'Fscores.mat'),'Mat_scores');
% [max, pos]= max(Mat_scores);
% fprintf(fid,'F max %f position in file %d',max,pos);
fclose(fid);
end

% Symbolic Aggregate Approximation\74\
folders_path = strcat(folders_path1,'Symbolic Aggregate Approximation\74\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\')
    outdir = strcat(outpath,'Modeling\SAX\74\',nameFolds{i},'\');
    mkdir(outdir);
    txt_resumen = strcat(outdir,'Fscores.txt')
    fid = fopen(txt_resumen,'a+');
    d2 = dir(in_path);
    isub = [d2(:).isdir]; %# returns logical vector
    nameFolds2 = {d2(isub).name}';
    nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
    Mat_scores = [];
    for j=1:size(nameFolds2,1)
        final_in_path = strcat(in_path,nameFolds2{j},'\train_test_data\')
        F = function_UT_LDMLTS_classif_and_save( final_in_path , outpath,tripletsfactor,cycle,alphafactor);
        path_name =  strcat(nameFolds2{j}, ' _ ', num2str(F),'\n');
        fprintf(fid, path_name);
        Mat_scores = [Mat_scores;F];
end

save(strcat(outdir,'Fscores.mat'),'Mat_scores');
% [max, pos]= max(Mat_scores);
% fprintf(fid,'F max %f position in file %d',max,pos);
fclose(fid);
end