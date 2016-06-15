clear all
close all
clc
% addpath(genpath('./code'))
addpath(genpath('./data'))  

dataset = 'MSRAction3D';
n_desired_frames = 76;


dir = 'MSRAction3D/MSRAction3D_data_0step_original_skel_data/';
mkdir(dir);
dir = 'MSRAction3D/MSRAction3D_data_1step_normalized_2_spine/';
mkdir(dir);
dir = 'MSRAction3D/MSRAction3D_data_2step_normalized_bones_size/';
mkdir(dir);
dir = 'MSRAction3D/MSRAction3D_data_3step_normalized_orientation/';
mkdir(dir);
dir = 'MSRAction3D/MSRAction3D_data_0step_original_skel_data_inter/';
mkdir(dir);
dir = 'MSRAction3D/MSRAction3D_data_1step_normalized_2_spine_inter/';
mkdir(dir);
dir = 'MSRAction3D/MSRAction3D_data_2step_normalized_bones_size_inter/';
mkdir(dir);
dir = 'MSRAction3D/MSRAction3D_data_3step_normalized_orientation_inter/';
mkdir(dir);

dir = [dataset,'/real_world_coordinates'];
load([dataset, '/files_used'])
load([dataset, '/body_model'])

n_actions = 20;
n_subjects = 10;
n_instances = 3;

skeletal_data = cell(n_actions, n_subjects, n_instances);
skeletal_data_validity = zeros(n_actions, n_subjects, n_instances);
n_sequences = length(find(skeletal_data_validity));        

features = cell(n_sequences, 1);
action_labels = zeros(n_sequences, 1);
subject_labels = zeros(n_sequences, 1);
instance_labels = zeros(n_sequences, 1); 

bone1_joints = body_model.primary_pairs(:,1:2);    
bone2_joints = body_model.primary_pairs(:,3:4);



count = 1;
for a = 1:n_actions
    for s = 1:n_subjects
        for e = 1:n_instances  

            name = sprintf('a%02i_s%02i_e%02i',a,s,e);
            if(sum(strmatch(name, files_used)))
                skeletal_data_validity(a, s, e) = 1;
                file = [dir, '/', sprintf('a%02i_s%02i_e%02i_skeleton3D.txt',a,s,e)];            
                fp = fopen(file);
                A = fscanf(fp,'%f');
                fclose(fp);
                n_frames = length(A) / 80;
                A = reshape(A, 4, 20, n_frames);

                normalized_joint_locations = A(1:3,:,:);     
                original_skeletal_data = zeros(size(normalized_joint_locations));
                hip_loc = zeros(3, n_frames);  
                frame_validity = ones(n_frames, 1);
                time_stamps = 1:n_frames;

                original_skeletal_data_ira = zeros(size(normalized_joint_locations));
                data_normalized_2_spine = zeros(size(normalized_joint_locations));
                data_normalized_bones_size = zeros(size(normalized_joint_locations));
                data_normalized_orientation = zeros(size(normalized_joint_locations));
                
                
                
                for n = 1:n_frames                    
                    temp = normalized_joint_locations(2,:, n);
                    normalized_joint_locations(2,:,n) = normalized_joint_locations(3,:,n);
                    normalized_joint_locations(3,:,n) = temp;

                    original_skeletal_data(:,:,n) = normalized_joint_locations(:,:,n);
                    original_skeletal_data_ira = original_skeletal_data;
                    %se pone el origen en el centro de la cadera
                    hip_loc(:,n) = normalized_joint_locations(:,body_model.hip_center_index,n);
                    normalized_joint_locations(:,:,n) = normalized_joint_locations(:,:,n) -...
                        repmat(hip_loc(:,n), 1, 20);
                    data_normalized_2_spine = normalized_joint_locations;
                    % se reescalan los huesos sin cambiar la
                        % orientacion de los angulos
                    % relative 3D angles
                    R = compute_relative_joint_angles(normalized_joint_locations(:,:,n),...
                        bone1_joints, bone2_joints);

                    reconstruct = 1;
                    for i = 1:body_model.n_primary_angles
                        if (isempty(R{i}))
                            reconstruct = 0;
                        end
                    end
                    if (reconstruct)
                        normalized_joint_locations(:,:,n) = reconstruct_joint_locations(R,...
                            bone1_joints, bone2_joints, body_model.bone_lengths);                            
                    else
                        frame_validity(n) = 0;
                    end 
                    %los huesos normalizados
                    data_normalized_bones_size = normalized_joint_locations;
                end
                frame_validity = (frame_validity == 1);

                normalized_joint_locations = normalized_joint_locations(:,:,frame_validity);
                time_stamps = time_stamps(frame_validity);   
                
                % se rotan los esqueletos para que estén mirando a
                % la cámara ESTO NO ESTA EN LO ORIGINAL
                normalized_joint_locations = rotate_the_skeletons(normalized_joint_locations, body_model);
                data_normalized_orientation = normalized_joint_locations;

                skeletal_data{a, s, e}.original_skeletal_data = original_skeletal_data;
                skeletal_data{a, s, e}.joint_locations = normalized_joint_locations;
                skeletal_data{a, s, e}.time_stamps = time_stamps;  
                
                % IRATI's CODE TO STORE THE NORMALIZED DATA IN
                % A DESIRABLE FORMAT
                %se pone change_data_format que es la de 20 joints
                result_data_original_skel_data = change_data_format(original_skeletal_data_ira);
                result_data_normalized_2_spine = change_data_format(data_normalized_2_spine);
                result_data_normalized_bones_size = change_data_format(data_normalized_bones_size);
                result_data_normalized_orientation = change_data_format(data_normalized_orientation);

                [data_original_skeletal_data_interpolated] = get_absolute_position_features_non_hip_origin(original_skeletal_data, body_model, n_desired_frames);
                [data_normalized_2_spine_interpolated] = get_absolute_position_features(data_normalized_2_spine, body_model, n_desired_frames);
                [data_normalized_bones_size_interpolated] = get_absolute_position_features(data_normalized_bones_size, body_model, n_desired_frames);
                [data_normalized_orientation_interpolated] = get_absolute_position_features(data_normalized_orientation, body_model, n_desired_frames);

                %Store it
                %not interpolated
%                
                 filename = strcat('MSRAction3D/MSRAction3D_data_0step_original_skel_data/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                 dlmwrite(filename, result_data_original_skel_data,' ');
                 filename = strcat('MSRAction3D/MSRAction3D_data_1step_normalized_2_spine/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                 result_data_normalized_2_spine = [result_data_normalized_2_spine(:,1:18) result_data_normalized_2_spine(:,22:end)];
                 dlmwrite(filename, result_data_normalized_2_spine,' ');
                 filename = strcat('MSRAction3D/MSRAction3D_data_2step_normalized_bones_size/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');                            
                 result_data_normalized_bones_size = [result_data_normalized_bones_size(:,1:18) result_data_normalized_bones_size(:,22:end)];
                 dlmwrite(filename, result_data_normalized_bones_size,' ');
                 result_data_normalized_orientation = [result_data_normalized_orientation(:,1:18) result_data_normalized_orientation(:,22:end)];
                 filename = strcat('MSRAction3D/MSRAction3D_data_3step_normalized_orientation/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                 dlmwrite(filename, result_data_normalized_orientation,' ');
                 %interpolated
                filename = strcat('MSRAction3D/MSRAction3D_data_0step_original_skel_data_inter/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                dlmwrite(filename, data_original_skeletal_data_interpolated,' ');
                filename = strcat('MSRAction3D/MSRAction3D_data_1step_normalized_2_spine_inter/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                dlmwrite(filename, data_normalized_2_spine_interpolated,' ');
                filename = strcat('MSRAction3D/MSRAction3D_data_2step_normalized_bones_size_inter/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                dlmwrite(filename, data_normalized_bones_size_interpolated,' ');
                filename = strcat('MSRAction3D/MSRAction3D_data_3step_normalized_orientation_inter/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                dlmwrite(filename, data_normalized_orientation_interpolated,' ');
               
            end
        end
    end
end






     
