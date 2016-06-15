% UT DMP modeling


%% thif file is the one responsible of the modelling of the trajectories using 
% Dynamic Movement Primitives

clc
clear all

% se calcula SAX solo de lo que está completamente preprocesado ya
inpath = 'C:\Ira\Data_Master\UT_Kinect\Position Data\74\'
outpath = 'C:\Ira\Data_Master\UT_Kinect\Modeling\Dynamic Movement Primitives\74\';
mkdir(outpath);

%% Florence_KINECT NOT interpolated
load_files_path = strcat(inpath,'UT_data_2step_normalized_bones_size\');
destination_path = strcat(outpath,'UT_data_2step_normalized_bones_size\');
frame_frec = 1/30; %the camputing hz in the database 
typeApproximation = 'lwr';
for numGausians=10:20
    compute_and_save_DMP_modelling(load_files_path, destination_path,frame_frec,numGausians,typeApproximation);
end


%% INTERPOLATED
load_files_path = strcat(inpath,'UT_data_2step_normalized_bones_size_inter\');
destination_path = strcat(outpath,'UT_data_2step_normalized_bones_size_inter\');
frame_frec = 1/15; %the camputing hz in the database 
typeApproximation = 'lwr';
for numGausians=10:20
    compute_and_save_DMP_modelling(load_files_path, destination_path,frame_frec,numGausians,typeApproximation);
end

%% Florence_KINECT NOT interpolated
load_files_path = strcat(inpath,'UT_data_3step_normalized_orientation\');
destination_path = strcat(outpath,'UT_data_3step_normalized_orientation\');
frame_frec = 1/30; %the camputing hz in the database 
typeApproximation = 'lwr';
for numGausians=10:20
    compute_and_save_DMP_modelling(load_files_path, destination_path,frame_frec,numGausians,typeApproximation);
end


%% INTERPOLATED
load_files_path = strcat(inpath,'UT_data_3step_normalized_orientation_inter\');
destination_path = strcat(outpath,'UT_data_3step_normalized_orientation_inter\');
frame_frec = 1/15; %the camputing hz in the database 
typeApproximation = 'lwr';
for numGausians=10:20
    compute_and_save_DMP_modelling(load_files_path, destination_path,frame_frec,numGausians,typeApproximation);
end

% if type is lwr, then centers and deviations should be given. The 
% centers or means belongs [0, 1] specify at which phase of the movement 
% the basis function becomes active. They are typically equally spaced 
% in the range of s and not modified during learning. The bandwidth of 
% the basis functions is given by h and is typically chosen such that 
% the Gaussians overlap.

