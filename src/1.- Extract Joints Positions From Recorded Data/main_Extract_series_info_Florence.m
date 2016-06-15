addpath ../../data/original_data/Florence3D/

folder_path = '../../data/processed_joint_positions/Florence/';
dir = strcat(folder_path,'Florence_data_0step_original_skel_data/');    mkdir(dir);
dir = strcat(folder_path,'Florence_data_1step_normalized_2_spine/'); mkdir(dir);
dir =  strcat(folder_path,'Florence_data_2step_normalized_bones_size/'); mkdir(dir);
dir =  strcat(folder_path,'Florence_data_3step_normalized_orientation/'); mkdir(dir);
dir =  strcat(folder_path,'Florence_data_0step_original_skel_data_inter/'); mkdir(dir);
dir =  strcat(folder_path,'Florence_data_1step_normalized_2_spine_inter/'); mkdir(dir);
dir =  strcat(folder_path,'Florence_data_2step_normalized_bones_size_inter/'); mkdir(dir);
dir =  strcat(folder_path,'Florence_data_3step_normalized_orientation_inter/'); mkdir(dir);

dataset = 'Florence3D';

%CHANGE THIS WHEN WANTING ANOTHER INTERPOLATION SIZE
n_desired_frames = 35;
    
load([dataset, '/body_model'])

file = [dataset, '/', 'world_coordinates.txt'];

bone1_joints = body_model.primary_pairs(:,1:2);    
bone2_joints = body_model.primary_pairs(:,3:4);

fp = fopen(file);
%en A está TODA la base de datos
A = fscanf(fp,'%f');
fclose(fp);
n_total_frames = length(A)/48;
%hace un reshape para tener mejor pinta con los datos
A = reshape(A, 48, n_total_frames);
video_id = A(1,:);
actor_id = A(2,:);
action_id = A(3,:);
A(1:3, :) = [];
A = A/(10^3);

n_videos = length(unique(video_id));
skeletal_data = cell(n_videos, 1);

for i = 1:n_videos
    ind = find(video_id == i);
    cur_video = A(:, ind);
    n_frames = length(ind);
    original_skeletal_data = zeros(3, 15, n_frames);
    normalized_joint_locations = zeros(3, 15, n_frames);

    original_skeletal_data = zeros(size(normalized_joint_locations));
    data_normalized_2_spine = zeros(size(normalized_joint_locations));
    data_normalized_bones_size = zeros(size(normalized_joint_locations));
    data_normalized_orientation = zeros(size(normalized_joint_locations));

    time_stamps = 1:n_frames;

    hip_loc = zeros(3, n_frames);                

    frame_validity = ones(1,n_frames);
            for n = 1:n_frames            
                normalized_joint_locations(:, :, n) = reshape(cur_video(:,n), 3, 15);
                temp = normalized_joint_locations(2,:, n);
                normalized_joint_locations(2,:,n) = normalized_joint_locations(3,:,n);
                normalized_joint_locations(3,:,n) = temp;

                original_skeletal_data(:, :, n) = normalized_joint_locations(:, :, n);

                hip_loc(:,n) = normalized_joint_locations(:,body_model.hip_center_index,n);            
                normalized_joint_locations(:,:,n) = normalized_joint_locations(:,:,n) - repmat(hip_loc(:,n), 1, 15);
                data_normalized_2_spine = normalized_joint_locations;
                
                R = compute_relative_joint_angles(normalized_joint_locations(:,:,n),...
                    bone1_joints, bone2_joints);

                reconstruct = 1;
                for p = 1:body_model.n_primary_angles
                    if (isempty(R{p}))
                        reconstruct = 0;
                    end
                end

                if (reconstruct)
                    normalized_joint_locations(:,:,n) = reconstruct_joint_locations(R,...
                        bone1_joints, bone2_joints, body_model.bone_lengths);
                else
                    frame_validity(n) = 0;                
                end    
                 data_normalized_bones_size = normalized_joint_locations;
            end

            frame_validity = (frame_validity == 1);

            normalized_joint_locations = normalized_joint_locations(:,:,frame_validity);        
            time_stamps = time_stamps(frame_validity);

            normalized_joint_locations = rotate_the_skeletons(normalized_joint_locations, body_model);
            data_normalized_orientation = normalized_joint_locations;
            
            
            result_data_original_skel_data = change_data_format2(original_skeletal_data);
            result_data_normalized_2_spine = change_data_format2(data_normalized_2_spine);
            result_data_normalized_bones_size = change_data_format2(data_normalized_bones_size);
            result_data_normalized_orientation = change_data_format2(data_normalized_orientation);

            [data_original_skeletal_data_interpolated] = get_absolute_position_features_non_hip_origin(original_skeletal_data, body_model, n_desired_frames);
            [data_normalized_2_spine_interpolated] = get_absolute_position_features(data_normalized_2_spine, body_model, n_desired_frames);
            [data_normalized_bones_size_interpolated] = get_absolute_position_features(data_normalized_bones_size, body_model, n_desired_frames);
            [data_normalized_orientation_interpolated] = get_absolute_position_features(data_normalized_orientation, body_model, n_desired_frames);


             %Store it
            %not interpolated
            % if not interpolated, after normalizing to spine, delete de
            % (0,0,0) position of the spine          
             filename = strcat( folder_path,'Florence_data_0step_original_skel_data/action_a',num2str(unique(action_id(ind))),'_subject_s',num2str(unique(actor_id(ind))), '_i_', num2str(i),'.txt');
             dlmwrite(filename, result_data_original_skel_data,' ');
             filename = strcat( folder_path,'Florence_data_1step_normalized_2_spine/action_a',num2str(unique(action_id(ind))),'_subject_s',num2str(unique(actor_id(ind))), '_i_', num2str(i),'.txt');
             result_data_normalized_2_spine = [result_data_normalized_2_spine(:,1:6) result_data_normalized_2_spine(:,10:end)];
             dlmwrite(filename, result_data_normalized_2_spine,' ');
             filename = strcat( folder_path,'Florence_data_2step_normalized_bones_size/action_a',num2str(unique(action_id(ind))),'_subject_s',num2str(unique(actor_id(ind))), '_i_', num2str(i),'.txt');                            
             result_data_normalized_bones_size = [result_data_normalized_bones_size(:,1:6) result_data_normalized_bones_size(:,10:end)];
             dlmwrite(filename, result_data_normalized_bones_size,' ');
             filename = strcat( folder_path,'Florence_data_3step_normalized_orientation/action_a',num2str(unique(action_id(ind))),'_subject_s',num2str(unique(actor_id(ind))), '_i_', num2str(i),'.txt');
             result_data_normalized_orientation = [result_data_normalized_orientation(:,1:6) result_data_normalized_orientation(:,10:end)];
             dlmwrite(filename, result_data_normalized_orientation,' ');
%              %interpolated
            filename = strcat( folder_path,'Florence_data_0step_original_skel_data_inter/action_a',num2str(unique(action_id(ind))),'_subject_s',num2str(unique(actor_id(ind))), '_i_', num2str(i),'.txt');
            dlmwrite(filename, data_original_skeletal_data_interpolated,' ');
            filename = strcat( folder_path,'Florence_data_1step_normalized_2_spine_inter/action_a',num2str(unique(action_id(ind))),'_subject_s',num2str(unique(actor_id(ind))), '_i_', num2str(i),'.txt');
            dlmwrite(filename, data_normalized_2_spine_interpolated,' ');
            filename = strcat( folder_path,'Florence_data_2step_normalized_bones_size_inter/action_a',num2str(unique(action_id(ind))),'_subject_s',num2str(unique(actor_id(ind))), '_i_', num2str(i),'.txt');
            dlmwrite(filename, data_normalized_bones_size_interpolated,' ');
            filename = strcat( folder_path,'Florence_data_3step_normalized_orientation_inter/action_a',num2str(unique(action_id(ind))),'_subject_s',num2str(unique(actor_id(ind))), '_i_', num2str(i),'.txt');
            dlmwrite(filename, data_normalized_orientation_interpolated,' ');

end      