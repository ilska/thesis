%Main baseline_removal and rescaling
inpath = 'C:\Ira\Data_Master\MSRAction3D\Position Data\76\'
outpath = 'C:\Ira\Data_Master\MSRAction3D\Modeling\Baseline Removal and Rescaling\76\';
mkdir(outpath);
%% MSRAction3D_KINECT NOT interpolated before orienting
load_files_path = strcat(inpath,'MSRAction3D_data_2step_normalized_bones_size\');
destination_path = strcat(outpath,'MSRAction3D_data_2step_normalized_bones_size\');
compute_and_save_baseline_removal_and_rescaling( load_files_path, destination_path );

%% MSRAction3D_KINECT Interpolated before orienting
load_files_path = strcat(inpath,'MSRAction3D_data_2step_normalized_bones_size_inter\');
destination_path = strcat(outpath,'MSRAction3D_data_2step_normalized_bones_size_inter\');
compute_and_save_baseline_removal_and_rescaling( load_files_path, destination_path );

%% MSRAction3D_KINECT NOT interpolated
load_files_path = strcat(inpath,'MSRAction3D_data_3step_normalized_orientation\');
destination_path = strcat(outpath,'MSRAction3D_data_3step_normalized_orientation\');
compute_and_save_baseline_removal_and_rescaling( load_files_path, destination_path );

%% MSRAction3D_KINECT Interpolated
load_files_path = strcat(inpath,'MSRAction3D_data_3step_normalized_orientation_inter\');
destination_path = strcat(outpath,'MSRAction3D_data_3step_normalized_orientation_inter\');
compute_and_save_baseline_removal_and_rescaling( load_files_path, destination_path );