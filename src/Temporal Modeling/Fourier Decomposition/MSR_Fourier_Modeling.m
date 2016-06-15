%% thif file is the one responsible of the modelling of the trajectories using 
% UT Fourier modeling
clc
clear all


inpath = 'C:\Ira\Data_Master\MSRAction3D\Position Data\76\'
outpath = 'C:\Ira\Data_Master\MSRAction3D\Modeling\Fourier Decomposition\76\';
mkdir(outpath);

%% UT_KINECT NOT interpolated
load_files_path = strcat(inpath,'MSRAction3D_data_2step_normalized_bones_size\');
destination_path = strcat(outpath,'MSRAction3D_data_2step_normalized_bones_size\');
n_coeffs = 76;
%se calcula primero con la largura de cada serie como numero de coefs
compute_and_save_Foutier_modelling(load_files_path, destination_path,n_coeffs,'no');
%luego se coge la largura que hemos puesto a los otros
for n_coeffs=10:20
    compute_and_save_Foutier_modelling(load_files_path, destination_path,n_coeffs,'ye');
end

% %% INTERPOLATED
load_files_path = strcat(inpath,'MSRAction3D_data_2step_normalized_bones_size_inter\');
destination_path = strcat(outpath,'MSRAction3D_data_2step_normalized_bones_size_inter\');
%se calcula primero con la largura de cada serie como numero de coefs
compute_and_save_Foutier_modelling(load_files_path, destination_path,n_coeffs,'no');
%luego se coge la largura que hemos puesto a los otros
for n_coeffs=10:20
    compute_and_save_Foutier_modelling(load_files_path, destination_path,n_coeffs,'ye');
end






%% UT_KINECT NOT interpolated
load_files_path = strcat(inpath,'MSRAction3D_data_3step_normalized_orientation\');
destination_path = strcat(outpath,'MSRAction3D_data_3step_normalized_orientation\');
n_coeffs = 76;
%se calcula primero con la largura de cada serie como numero de coefs
compute_and_save_Foutier_modelling(load_files_path, destination_path,n_coeffs,'no');
%luego se coge la largura que hemos puesto a los otros
for n_coeffs=10:20
    compute_and_save_Foutier_modelling(load_files_path, destination_path,n_coeffs,'ye');
end

% %% INTERPOLATED
load_files_path = strcat(inpath,'MSRAction3D_data_3step_normalized_orientation_inter\');
destination_path = strcat(outpath,'MSRAction3D_data_3step_normalized_orientation_inter\');
%se calcula primero con la largura de cada serie como numero de coefs
compute_and_save_Foutier_modelling(load_files_path, destination_path,n_coeffs,'no');
%luego se coge la largura que hemos puesto a los otros
for n_coeffs=10:20
    compute_and_save_Foutier_modelling(load_files_path, destination_path,n_coeffs,'ye');
end

