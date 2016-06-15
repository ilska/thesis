
%Main SAX
clear all
close all
clc
% se calcula SAX solo de lo que está completamente preprocesado ya
inpath = 'C:\Ira\Data_Master\MSRAction3D\Position Data\76\'
outpath = 'C:\Ira\Data_Master\MSRAction3D\Modeling\Piecewise Aggregate Approximation\76\';
mkdir(outpath);


load_files_path = strcat(inpath,'MSRAction3D_data_2step_normalized_bones_size\');
destination_path = strcat(outpath,'MSRAction3D_data_2step_normalized_bones_size\');
for alphabet_size = 5:20
    for nsegments = 10:20
        compute_and_save_PAA( load_files_path, destination_path,alphabet_size,nsegments );
    end
end
%% UT_KINECT Interpolated

load_files_path = strcat(inpath,'MSRAction3D_data_2step_normalized_bones_size_inter\');
destination_path = strcat(outpath,'MSRAction3D_data_2step_normalized_bones_size_inter\');
for alphabet_size = 5:20
    for nsegments = 10:20
        compute_and_save_PAA( load_files_path, destination_path,alphabet_size,nsegments );
    end
end





%% UT_KINECT NOT interpolated

load_files_path = strcat(inpath,'MSRAction3D_data_3step_normalized_orientation\');
destination_path = strcat(outpath,'MSRAction3D_data_3step_normalized_orientation\');
for alphabet_size = 5:20
    for nsegments = 10:20
        compute_and_save_PAA( load_files_path, destination_path,alphabet_size,nsegments );
    end
end
%% UT_KINECT Interpolated

load_files_path = strcat(inpath,'MSRAction3D_data_3step_normalized_orientation_inter\');
destination_path = strcat(outpath,'MSRAction3D_data_3step_normalized_orientation_inter\');
for alphabet_size = 5:20
    for nsegments = 10:20
        compute_and_save_PAA( load_files_path, destination_path,alphabet_size,nsegments );
    end
end



