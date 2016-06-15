    clear all
    close all
    clc
    addpath(genpath('./code'))
    addpath(genpath('./data'))   
    
    
    dir = 'UT_Kinect/UT_data_0step_original_skel_data/';
    mkdir(dir);
    dir = 'UT_Kinect/UT_data_1step_normalized_2_spine/';
    mkdir(dir);
    dir = 'UT_Kinect/UT_data_2step_normalized_bones_size/';
    mkdir(dir);
    dir = 'UT_Kinect/UT_data_3step_normalized_orientation/';
    mkdir(dir);
    dir = 'UT_Kinect/UT_data_0step_original_skel_data_inter/';
    mkdir(dir);
    dir = 'UT_Kinect/UT_data_1step_normalized_2_spine_inter/';
    mkdir(dir);
    dir = 'UT_Kinect/UT_data_2step_normalized_bones_size_inter/';
    mkdir(dir);
    dir = 'UT_Kinect/UT_data_3step_normalized_orientation_inter/';
    mkdir(dir);

    dataset = 'UTKinect';
    joints_order = [5, 9, 3, 2, 13, 17, 1, 6, 10, 7, 11, 8, 12, 14, 18, 15, 19, 16, 20, 4];

    directory = [dataset, '/joints'];
    load([directory, '/frame_indices']);
    load([dataset, '/body_model'])

    n_actions = 10;
    n_subjects = 10;
    n_instances = 2;
    
    n_desired_frames = 74;

    bone1_joints = body_model.primary_pairs(:,1:2);    
    bone2_joints = body_model.primary_pairs(:,3:4);

    skeletal_data = cell(n_actions, n_subjects, n_instances);
    skeletal_data_validity = zeros(n_actions, n_subjects, n_instances);
    for s = 1:n_subjects        
        for e = 1:n_instances            
            file = [directory, '/', sprintf('joints_s%02i_e%02i.txt',s,e)];            
            fp = fopen(file);
            A = fscanf(fp,'%f');
            fclose(fp);

            frame_no = A(1:61:end);
            A(1:61:end) = [];
            n_frames = length(A) / 60;
            A = reshape(A, 3, 20, n_frames);

            [frame_no, unique_ind] = unique(frame_no);
            A = A(:,:, unique_ind);

            action_frame_limits = frame_indices{s,e};
            for a = 1:n_actions

                if (~sum(isnan(action_frame_limits(a,:))))
                    skeletal_data_validity(a, s, e) = 1;                    

                    [~,ind1] = min(abs(frame_no - action_frame_limits(a,1)));
                    [~,ind2] = min(abs(frame_no - action_frame_limits(a,2)));

                    normalized_joint_locations = A(:,joints_order, ind1:ind2);
                    original_skeletal_data = zeros(size(normalized_joint_locations));
                    data_normalized_2_spine = zeros(size(normalized_joint_locations));
                    data_normalized_bones_size = zeros(size(normalized_joint_locations));
                    data_normalized_orientation = zeros(size(normalized_joint_locations));
                    
                    time_stamps = frame_no(ind1:ind2) - frame_no(ind1) + 1;

                    n_frames = ind2 - ind1 + 1;                    

                    hip_loc = zeros(3, n_frames);

                    frame_validity = ones(1,n_frames);
                    for n = 1:n_frames                    
                        temp = normalized_joint_locations(2,:, n);
                        normalized_joint_locations(2,:,n) = normalized_joint_locations(3,:,n);
                        normalized_joint_locations(3,:,n) = temp;

                        original_skeletal_data(:,:,n) = normalized_joint_locations(:,:,n);
                        %se pone el origen en el centro de la cadera
                        hip_loc(:,n) = normalized_joint_locations(:,body_model.hip_center_index,n);
                        normalized_joint_locations(:,:,n) = normalized_joint_locations(:,:,n) - repmat(hip_loc(:,n), 1, 20);
                        data_normalized_2_spine = normalized_joint_locations;
                        % se reescalan los huesos sin cambiar la
                        % orientacion de los angulos
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
                      data_normalized_bones_size = normalized_joint_locations;

                    end
                    frame_validity = (frame_validity == 1);

                    normalized_joint_locations = normalized_joint_locations(:,:,frame_validity);
                    time_stamps = time_stamps(frame_validity);
                    
                    
                    % se rotan los esqueletos para que estén mirando a
                    % la cámara
                    normalized_joint_locations = rotate_the_skeletons(normalized_joint_locations, body_model);
                    data_normalized_orientation = normalized_joint_locations;

                    if (a == 5 && s == 9 && (e == 1 || e == 2))
                        skeletal_data{a, s, e}.original_skeletal_data = original_skeletal_data(:,:,1:2:end);
                        skeletal_data{a, s, e}.joint_locations = normalized_joint_locations(:,:,1:2:end);
                        skeletal_data{a, s, e}.time_stamps = time_stamps(1:2:end);  
                        data_normalized_2_spine = data_normalized_2_spine(:,:,1:2:end);
                        data_normalized_bones_size = data_normalized_bones_size(:,:,1:2:end);
                        data_normalized_orientation = data_normalized_orientation(:,:,1:2:end);
                        % IRATI's CODE TO STORE THE NORMALIZED DATA IN
                        % A DESIRABLE FORMAT
                        
                        result_data_original_skel_data = change_data_format(original_skeletal_data(:,:,1:2:end));
                        result_data_normalized_2_spine = change_data_format(data_normalized_2_spine);
                        result_data_normalized_bones_size = change_data_format(data_normalized_bones_size);
                        result_data_normalized_orientation = change_data_format(data_normalized_orientation);
                        
                        [data_original_skeletal_data_interpolated] = get_absolute_position_features_non_hip_origin(original_skeletal_data, body_model, n_desired_frames);
                        [data_normalized_2_spine_interpolated] = get_absolute_position_features(data_normalized_2_spine, body_model, n_desired_frames);
                        [data_normalized_bones_size_interpolated] = get_absolute_position_features(data_normalized_bones_size, body_model, n_desired_frames);
                        [data_normalized_orientation_interpolated] = get_absolute_position_features(data_normalized_orientation, body_model, n_desired_frames);
                          
                        
                                              %Store it
                        %not interpolated
                         
                         filename = strcat('UT_Kinect/UT_data_0step_original_skel_data/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                         dlmwrite(filename, result_data_original_skel_data,' ');
                         filename = strcat('UT_Kinect/UT_data_1step_normalized_2_spine/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                         result_data_normalized_2_spine = [result_data_normalized_2_spine(:,1:18) result_data_normalized_2_spine(:,22:end)];
                         dlmwrite(filename, result_data_normalized_2_spine,' ');
                         filename = strcat('UT_Kinect/UT_data_2step_normalized_bones_size/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');                            
                         result_data_normalized_bones_size = [result_data_normalized_bones_size(:,1:18) result_data_normalized_bones_size(:,22:end)];
                         dlmwrite(filename, result_data_normalized_bones_size,' ');
                         result_data_normalized_orientation = [result_data_normalized_orientation(:,1:18) result_data_normalized_orientation(:,22:end)];
                         filename = strcat('UT_Kinect/UT_data_3step_normalized_orientation/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                         dlmwrite(filename, result_data_normalized_orientation,' ');
                         %interpolated
                        filename = strcat('UT_Kinect/UT_data_0step_original_skel_data_inter/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                        dlmwrite(filename, data_original_skeletal_data_interpolated,' ');
                        filename = strcat('UT_Kinect/UT_data_1step_normalized_2_spine_inter/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                        dlmwrite(filename, data_normalized_2_spine_interpolated,' ');
                        filename = strcat('UT_Kinect/UT_data_2step_normalized_bones_size_inter/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                        dlmwrite(filename, data_normalized_bones_size_interpolated,' ');
                        filename = strcat('UT_Kinect/UT_data_3step_normalized_orientation_inter/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                        dlmwrite(filename, data_normalized_orientation_interpolated,' ');
                        
                    else
                        skeletal_data{a, s, e}.original_skeletal_data = original_skeletal_data;
                        skeletal_data{a, s, e}.joint_locations = normalized_joint_locations;
                        skeletal_data{a, s, e}.time_stamps = time_stamps;
%                         data_normalized_2_spine = data_normalized_2_spine;
%                         data_normalized_bones_size = data_normalized_bones_size;
%                         data_normalized_orientation = data_normalized_orientation;
                        
                        %Create the data to store it
                        result_data_original_skel_data = change_data_format(original_skeletal_data);
                        result_data_normalized_2_spine = change_data_format(data_normalized_2_spine);
                        result_data_normalized_bones_size = change_data_format(data_normalized_bones_size);
                        result_data_normalized_orientation = change_data_format(data_normalized_orientation);
                        
                        [data_original_skeletal_data_interpolated] = get_absolute_position_features_non_hip_origin(original_skeletal_data, body_model, n_desired_frames);
                        [data_normalized_2_spine_interpolated] = get_absolute_position_features(data_normalized_2_spine, body_model, n_desired_frames);
                        [data_normalized_bones_size_interpolated] = get_absolute_position_features(data_normalized_bones_size, body_model, n_desired_frames);
                        [data_normalized_orientation_interpolated] = get_absolute_position_features(data_normalized_orientation, body_model, n_desired_frames);
                        
                        %Store it
                        %not interpolated
                              filename = strcat('UT_Kinect/UT_data_0step_original_skel_data/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                         dlmwrite(filename, result_data_original_skel_data,' ');
                         filename = strcat('UT_Kinect/UT_data_1step_normalized_2_spine/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                         result_data_normalized_2_spine = [result_data_normalized_2_spine(:,1:18) result_data_normalized_2_spine(:,22:end)];
                         dlmwrite(filename, result_data_normalized_2_spine,' ');
                         filename = strcat('UT_Kinect/UT_data_2step_normalized_bones_size/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');                            
                         result_data_normalized_bones_size = [result_data_normalized_bones_size(:,1:18) result_data_normalized_bones_size(:,22:end)];
                         dlmwrite(filename, result_data_normalized_bones_size,' ');
                         result_data_normalized_orientation = [result_data_normalized_orientation(:,1:18) result_data_normalized_orientation(:,22:end)];
                         filename = strcat('UT_Kinect/UT_data_3step_normalized_orientation/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                         dlmwrite(filename, result_data_normalized_orientation,' ');
                         %interpolated
                        filename = strcat('UT_Kinect/UT_data_0step_original_skel_data_inter/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                        dlmwrite(filename, data_original_skeletal_data_interpolated,' ');
                        filename = strcat('UT_Kinect/UT_data_1step_normalized_2_spine_inter/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                        dlmwrite(filename, data_normalized_2_spine_interpolated,' ');
                        filename = strcat('UT_Kinect/UT_data_2step_normalized_bones_size_inter/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                        dlmwrite(filename, data_normalized_bones_size_interpolated,' ');
                        filename = strcat('UT_Kinect/UT_data_3step_normalized_orientation_inter/action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
                        dlmwrite(filename, data_normalized_orientation_interpolated,' ');

                    end

                    skeletal_data{a, s, e}.action = a;
                    skeletal_data{a, s, e}.subject = s;
                    skeletal_data{a, s, e}.instance = e;
                end                
            end
        end
    end