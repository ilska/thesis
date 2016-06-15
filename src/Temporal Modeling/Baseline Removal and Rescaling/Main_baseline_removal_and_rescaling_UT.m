
%Main baseline_removal and rescaling
%Main baseline_removal and rescaling
inpath = 'C:\Ira\Data_Master\UT_Kinect\Position Data\74\'
outpath = 'C:\Ira\Data_Master\UT_Kinect\Modeling\Baseline Removal and Rescaling\74\';
mkdir(outpath);

%% UT_KINECT NOT interpolated
load_files_path = strcat(inpath,'UT_data_2step_normalized_bones_size\');
destination_path = strcat(outpath,'UT_data_2step_normalized_bones_size\');
compute_and_save_baseline_removal_and_rescaling( load_files_path, destination_path );

%% UT_KINECT Interpolated
load_files_path = strcat(inpath,'UT_data_2step_normalized_bones_size_inter\');
destination_path = strcat(outpath,'UT_data_2step_normalized_bones_size_inter\');
compute_and_save_baseline_removal_and_rescaling( load_files_path, destination_path );

%% oriented
load_files_path = strcat(inpath,'UT_data_3step_normalized_orientation\');
destination_path = strcat(outpath,'UT_data_3step_normalized_orientation\');
compute_and_save_baseline_removal_and_rescaling( load_files_path, destination_path );

%% UT_KINECT Interpolated
load_files_path = strcat(inpath,'UT_data_3step_normalized_orientation_inter\');
destination_path = strcat(outpath,'UT_data_3step_normalized_orientation_inter\');
compute_and_save_baseline_removal_and_rescaling( load_files_path, destination_path );