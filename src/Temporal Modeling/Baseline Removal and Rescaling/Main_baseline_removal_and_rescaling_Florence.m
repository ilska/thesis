
%Main baseline_removal and rescaling
inpath = 'C:\Ira\Data_Master\Florence\Position Data\35\'
outpath = 'C:\Ira\Data_Master\Florence\Modeling\Baseline Removal and Rescaling\35\';
mkdir(outpath);

%% FLORENCE NOT interpolated
load_files_path = strcat(inpath,'Florence_data_2step_normalized_bones_size\');
destination_path = strcat(outpath,'Florence_data_2step_normalized_bones_size\');
compute_and_save_baseline_removal_and_rescaling( load_files_path, destination_path );

%% FLORENCE Interpolated
load_files_path = strcat(inpath,'Florence_data_2step_normalized_bones_size_inter\');
destination_path = strcat(outpath,'Florence_data_2step_normalized_bones_size_inter\');
compute_and_save_baseline_removal_and_rescaling( load_files_path, destination_path );

%% FLORENCE NOT interpolated
load_files_path = strcat(inpath,'Florence_data_3step_normalized_orientation\');
destination_path = strcat(outpath,'Florence_data_3step_normalized_orientation\');
compute_and_save_baseline_removal_and_rescaling( load_files_path, destination_path );

%% FLORENCE Interpolated
load_files_path = strcat(inpath,'Florence_data_3step_normalized_orientation_inter\');
destination_path = strcat(outpath,'Florence_data_3step_normalized_orientation_inter\');
compute_and_save_baseline_removal_and_rescaling( load_files_path, destination_path );