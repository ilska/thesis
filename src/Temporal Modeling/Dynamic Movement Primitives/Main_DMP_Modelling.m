
%% thif file is the one responsible of the modelling of the trajectories using 
% Dynamic Movement Primitives

clc
clear all

% se calcula SAX solo de lo que está completamente preprocesado ya
inpath = 'C:\Users\ilska\Box Sync\Thesis Experiments\Data_Master\Florence\Position Data\35\'
outpath = 'C:\Users\ilska\Box Sync\Thesis Experiments\Data_Master\Florence\Modeling\Dynamic Movement Primitives\35\';
mkdir(outpath);
%% Florence_KINECT NOT interpolated
load_files_path = strcat(inpath,'Florence_data_3step_normalized_orientation\');
destination_path = strcat(outpath,'Florence_data_3step_normalized_orientation\');
frame_frec = 1/15; %the camputing hz in the database 
typeApproximation = 'lwr';
for numGausians=10:20
    compute_and_save_DMP_modelling(load_files_path, destination_path,frame_frec,numGausians,typeApproximation);
end

typeApproximation = 'linear';
for numGausians=10:20
    compute_and_save_DMP_modelling(load_files_path, destination_path,frame_frec,numGausians,typeApproximation);
end

typeApproximation = 'fourier';
for numGausians=10:20
    compute_and_save_DMP_modelling(load_files_path, destination_path,frame_frec,numGausians,typeApproximation);
end





%% INTERPOLATED
load_files_path = strcat(inpath,'Florence_data_3step_normalized_orientation_inter\');
destination_path = strcat(outpath,'Florence_data_3step_normalized_orientation_inter\');
frame_frec = 1/15; %the camputing hz in the database 
typeApproximation = 'lwr';
for numGausians=10:20
    compute_and_save_DMP_modelling(load_files_path, destination_path,frame_frec,numGausians,typeApproximation);
end

typeApproximation = 'linear';
for numGausians=10:20
    compute_and_save_DMP_modelling(load_files_path, destination_path,frame_frec,numGausians,typeApproximation);
end

typeApproximation = 'fourier';
for numGausians=10:20
    compute_and_save_DMP_modelling(load_files_path, destination_path,frame_frec,numGausians,typeApproximation);
end







% if type is lwr, then centers and deviations should be given. The 
% centers or means belongs [0, 1] specify at which phase of the movement 
% the basis function becomes active. They are typically equally spaced 
% in the range of s and not modified during learning. The bandwidth of 
% the basis functions is given by h and is typically chosen such that 
% the Gaussians overlap.

