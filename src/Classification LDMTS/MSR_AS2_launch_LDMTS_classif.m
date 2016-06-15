
%% Florence,launch classif
clear all
close all
clc

addpath('LDMLT_TS')
%Load the data from the folder
master_path = 'C:\Ira\Data_Master\MSRAction3D\'
outpath = 'C:\Ira\Results_Master\MSRAction3D\AS2\';
% mkdir(outpath);
%training params
tripletsfactor = 20; % era 20
cycle = 1;
alphafactor = 5;% era 5;


% % Position
% folders_path = strcat(master_path,'Position Data\76\');
% d = dir(folders_path);
% isub = [d(:).isdir]; %# returns logical vector
% nameFolds = {d(isub).name}';
% nameFolds(ismember(nameFolds,{'.','..'})) = [];
% 
% outdir = strcat(outpath,'Position Data\76\');
% mkdir(outdir);
% txt_resumen = strcat(outdir,'Fscores.txt')
% fid = fopen(txt_resumen,'a+');
% Mat_scores = []; 
% Mat_result_cells = [];
% for i = 1:size(nameFolds,1)
%     in_path = strcat(folders_path,nameFolds{i},'\AS2\train_test_data\');
%     statistics_cell = function_MSRAction3D_LDMLTS_classif_and_save( in_path , outpath,tripletsfactor,cycle,alphafactor);
%     result_cell = function_create_result_struct( statistics_cell, nameFolds{i} );
%     F = statistics_cell.mean_Fscore;
%     path_name =  strcat(nameFolds{i}, ' _ ', num2str(F),'\n');
%     fprintf(fid, path_name);
%     Mat_scores = [Mat_scores;F];  
%     Mat_result_cells = [Mat_result_cells; result_cell];
% end
% 
% save(strcat(outdir,'Fscores.mat'),'Mat_scores'); 
% save(strcat(outdir,'Result_cells.mat'),'Mat_result_cells');
% fclose(fid);

% Temporal Modeling
 folders_path1 = strcat(master_path,'Modeling\');

% %baseline removal
% folders_path = strcat(folders_path1,'Baseline Removal and Rescaling\76\');
% d = dir(folders_path);
% isub = [d(:).isdir]; %# returns logical vector
% nameFolds = {d(isub).name}';
% nameFolds(ismember(nameFolds,{'.','..'})) = [];
% outdir = strcat(outpath,'Modeling\Baseline Removal and Rescaling\76\');
% mkdir(outdir);
% txt_resumen = strcat(outdir,'Fscores.txt')
% fid = fopen(txt_resumen,'a+');
% Mat_scores = []; 
% Mat_result_cells = [];
% for i = 1:size(nameFolds,1)
%     
%     in_path = strcat(folders_path,nameFolds{i},'\AS2\train_test_data\');
% 	statistics_cell = function_MSRAction3D_LDMLTS_classif_and_save( in_path , outpath,tripletsfactor,cycle,alphafactor);
%     result_cell = function_create_result_struct( statistics_cell, nameFolds{i} );
%     F = statistics_cell.mean_Fscore;
%     path_name =  strcat(nameFolds{i}, ' _ ', num2str(F),'\n');
%     fprintf(fid, path_name);
%     Mat_scores = [Mat_scores;F];  
%     Mat_result_cells = [Mat_result_cells; result_cell];
% end
% 
% save(strcat(outdir,'Fscores.mat'),'Mat_scores');
% save(strcat(outdir,'Result_cells.mat'),'Mat_result_cells');
% fclose(fid);
% 
% %Dynamic Movement Primitives
% folders_path = strcat(folders_path1,'Dynamic Movement Primitives\76\');
% d = dir(folders_path);
% isub = [d(:).isdir]; %# returns logical vector
% nameFolds = {d(isub).name}';
% nameFolds(ismember(nameFolds,{'.','..'})) = [];
% 
% for i = 1:size(nameFolds,1)
%     in_path = strcat(folders_path,nameFolds{i},'\')
%     outdir = strcat(outpath,'Modeling\DMP\76\',nameFolds{i},'\');
%     mkdir(outdir);
%     mkdir(outdir);
%     txt_resumen = strcat(outdir,'Fscores.txt')
%     fid = fopen(txt_resumen,'a+');
%     d2 = dir(in_path);
%     isub = [d2(:).isdir]; %# returns logical vector
%     nameFolds2 = {d2(isub).name}';
%     nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
%     Mat_scores = [];
%     Mat_result_cells = [];
%     for j=1:size(nameFolds2,1)
%         final_in_path = strcat(in_path,nameFolds2{j},'\AS2\train_test_data\');
%         statistics_cell = function_MSRAction3D_LDMLTS_classif_and_save( final_in_path , outpath,tripletsfactor,cycle,alphafactor);
%         result_cell = function_create_result_struct( statistics_cell, nameFolds2{j} );
%         F = statistics_cell.mean_Fscore;
%         path_name =  strcat(nameFolds2{j}, ' _ ', num2str(F),'\n');
%         fprintf(fid, path_name);
%         Mat_scores = [Mat_scores;F];  
%         Mat_result_cells = [Mat_result_cells; result_cell];
%     end
% 
%     save(strcat(outdir,'Fscores.mat'),'Mat_scores'); 
%     save(strcat(outdir,'Result_cells.mat'),'Mat_result_cells');
% %      
% %     fprintf(fid,'F max %f position in file %d',max,pos);
%      fclose(fid);
% end
% 
% % Fourier Decomposition
% folders_path = strcat(folders_path1,'Fourier Decomposition\76\');
% d = dir(folders_path);
% isub = [d(:).isdir]; %# returns logical vector
% nameFolds = {d(isub).name}';
% nameFolds(ismember(nameFolds,{'.','..'})) = [];
% for i = 1:size(nameFolds,1)
%     in_path = strcat(folders_path,nameFolds{i},'\')
%     outdir = strcat(outpath,'Modeling\Fourier\76\',nameFolds{i},'\');
%     mkdir(outdir);
%     txt_resumen = strcat(outdir,'Fscores.txt')
%     fid = fopen(txt_resumen,'a+');
%     d2 = dir(in_path);
%     isub = [d2(:).isdir]; %# returns logical vector
%     nameFolds2 = {d2(isub).name}';
%     nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
%     Mat_scores = []; 
%     Mat_result_cells = [];
%     for j=1:size(nameFolds2,1)
%         final_in_path = strcat(in_path,nameFolds2{j},'\AS2\train_test_data\');
%         statistics_cell = function_MSRAction3D_LDMLTS_classif_and_save( final_in_path , outpath,tripletsfactor,cycle,alphafactor);
%     	result_cell = function_create_result_struct( statistics_cell, nameFolds2{j} );
%         F = statistics_cell.mean_Fscore;
%         path_name =  strcat(nameFolds2{j}, ' _ ', num2str(F),'\n');
%         fprintf(fid, path_name);
%         Mat_scores = [Mat_scores;F]; 
%         Mat_result_cells = [Mat_result_cells; result_cell];
% end
% 
% save(strcat(outdir,'Fscores.mat'),'Mat_scores');
% save(strcat(outdir,'Result_cells.mat'),'Mat_result_cells');
% 
% fclose(fid);
% end
% 
% % Piecewise Aggregate Approximation\76\
% folders_path = strcat(folders_path1,'Piecewise Aggregate Approximation\76\');
% d = dir(folders_path);
% isub = [d(:).isdir]; %# returns logical vector
% nameFolds = {d(isub).name}';
% nameFolds(ismember(nameFolds,{'.','..'})) = [];
% for i = 1:size(nameFolds,1)
%     in_path = strcat(folders_path,nameFolds{i},'\')
%     outdir = strcat(outpath,'Modeling\PAA\76\',nameFolds{i},'\');
%     mkdir(outdir);
%     txt_resumen = strcat(outdir,'Fscores.txt')
%     fid = fopen(txt_resumen,'a+');
%     d2 = dir(in_path);
%     isub = [d2(:).isdir]; %# returns logical vector
%     nameFolds2 = {d2(isub).name}';
%     nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
%     Mat_scores = []; Mat_result_cells = [];
%     for j=1:size(nameFolds2,1)
%         final_in_path = strcat(in_path,nameFolds2{j},'\AS2\train_test_data\')
%         statistics_cell = function_MSRAction3D_LDMLTS_classif_and_save( final_in_path , outpath,tripletsfactor,cycle,alphafactor);
%      	result_cell = function_create_result_struct( statistics_cell, nameFolds2{j} );
%         F = statistics_cell.mean_Fscore;
%         path_name =  strcat(nameFolds2{j}, ' _ ', num2str(F),'\n');
%         fprintf(fid, path_name);
%         Mat_scores = [Mat_scores;F]; 
%         Mat_result_cells = [Mat_result_cells; result_cell];
% end
% 
% save(strcat(outdir,'Fscores.mat'),'Mat_scores'); 
% save(strcat(outdir,'Result_cells.mat'),'Mat_result_cells');
% %  
% % fprintf(fid,'F max %f position in file %d',max,pos);
% fclose(fid);
% end

% Symbolic Aggregate Approximation\76\
folders_path = strcat(folders_path1,'Symbolic Aggregate Approximation\76\');
d = dir(folders_path);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i = 1:size(nameFolds,1)
    in_path = strcat(folders_path,nameFolds{i},'\')
    outdir = strcat(outpath,'Modeling\SAX\76\',nameFolds{i},'\');
    mkdir(outdir);
    txt_resumen = strcat(outdir,'Fscores.txt')
    fid = fopen(txt_resumen,'a+');
    d2 = dir(in_path);
    isub = [d2(:).isdir]; %# returns logical vector
    nameFolds2 = {d2(isub).name}';
    nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
    Mat_scores = []; Mat_result_cells = [];
    for j=1:size(nameFolds2,1)
        final_in_path = strcat(in_path,nameFolds2{j},'\AS2\train_test_data\')
        statistics_cell = function_MSRAction3D_LDMLTS_classif_and_save( final_in_path , outpath,tripletsfactor,cycle,alphafactor);
        result_cell = function_create_result_struct( statistics_cell, nameFolds2{j} );
        F = statistics_cell.mean_Fscore;
        path_name =  strcat(nameFolds2{j}, ' _ ', num2str(F),'\n');
        fprintf(fid, path_name);
        Mat_scores = [Mat_scores;F];  
        Mat_result_cells = [Mat_result_cells; result_cell];
end

save(strcat(outdir,'Fscores.mat'),'Mat_scores'); 
save(strcat(outdir,'Result_cells.mat'),'Mat_result_cells');
%  
% fprintf(fid,'F max %f position in file %d',max,pos);
fclose(fid);
end