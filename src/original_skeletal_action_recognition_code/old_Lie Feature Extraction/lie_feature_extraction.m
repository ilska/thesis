%%%
clear all
close all
clc

%% Irati Lie group feature Extraction

addpath(genpath('./code'))
addpath(genpath('./data'))

dataset_idx = 1;

feature_types = {'absolute_joint_positions', 'relative_joint_positions',...
                     'joint_angles_quaternions', 'SE3_lie_algebra_absolute_pairs',...
                     'SE3_lie_algebra_relative_pairs'};

datasets = {'UTKinect', 'Florence3D', 'MSRAction3D'};



% All the action sequences in a dataset are interpolated to have same
% length. 'desired_frames' is the reference length.
if (strcmp(datasets{dataset_idx}, 'UTKinect'))       
    desired_frames = 74;  

elseif (strcmp(datasets{dataset_idx}, 'Florence3D'))
    desired_frames = 35;

elseif (strcmp(datasets{dataset_idx}, 'MSRAction3D'))
    desired_frames = 76;
    
end



%% Skeletal representation
directory = ['E:/Thesis/Programing/WORKING_FORLDER/Data_Master/',datasets{dataset_idx}, '/LieExperiments/', feature_types{1}];
mkdir(directory)
disp ('Generating skeletal representation')
% generate_features(directory, datasets{dataset_idx}, feature_types{1}, desired_frames);
directory = ['E:/Thesis/Programing/WORKING_FORLDER/Data_Master/',datasets{dataset_idx}, '/LieExperiments/', feature_types{5}];
mkdir(directory)  
generate_features(directory, datasets{dataset_idx}, feature_types{5}, desired_frames);