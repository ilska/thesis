function [] = process_skeletal_data(dataset)

    dbstop if error

    if (strcmp(dataset, 'UTKinect'))

        joints_order = [5, 9, 3, 2, 13, 17, 1, 6, 10, 7, 11, 8, 12, 14, 18, 15, 19, 16, 20, 4];

        directory = [dataset, '/joints'];
        load([directory, '/frame_indices']);
        load([dataset, '/body_model'])

        n_actions = 10;
        n_subjects = 10;
        n_instances = 2;

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
                        end
                        frame_validity = (frame_validity == 1);

                        normalized_joint_locations = normalized_joint_locations(:,:,frame_validity);
                        time_stamps = time_stamps(frame_validity);

                        % se rotan los esqueletos para que estén mirando a
                        % la cámara
                        normalized_joint_locations = rotate_the_skeletons(normalized_joint_locations, body_model);

                       
                        if (a == 5 && s == 9 && (e == 1 || e == 2))
                            skeletal_data{a, s, e}.original_skeletal_data = original_skeletal_data(:,:,1:2:end);
                            skeletal_data{a, s, e}.joint_locations = normalized_joint_locations(:,:,1:2:end);
                            skeletal_data{a, s, e}.time_stamps = time_stamps(1:2:end);  
                            % IRATI's CODE TO STORE THE NORMALIZED DATA IN
                            % A DESIRABLE FORMAT
                            the_normalized_they_store = normalized_joint_locations(:,:,1:2:end);
                            iras_final_normalize_joint = zeros(size(the_normalized_they_store,3),60);
                            for ira_frame=1:size(the_normalized_they_store,3)
                                iras_frame = the_normalized_they_store(:,:,ira_frame);
                                contador = 1;
                                for ira_col=1:20
                                    col = iras_frame(:,ira_col);
                                    transformed = col';
                                    iras_final_normalize_joint(ira_frame,contador:contador+2) = transformed;
                                    contador = contador +3;
                                end
                            end
%                             filename = strcat('action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
%                             dlmwrite(filename, iras_final_normalize_joint,' ');
                            % END IRATI
                        else
                            skeletal_data{a, s, e}.original_skeletal_data = original_skeletal_data;
                            skeletal_data{a, s, e}.joint_locations = normalized_joint_locations;
                            skeletal_data{a, s, e}.time_stamps = time_stamps;
                            
                            % IRATI's CODE TO STORE THE NORMALIZED DATA IN
                            % A DESIRABLE FORMAT
                            iras_final_normalize_joint = zeros(n_frames,60);
                            for ira_frame=1:n_frames
                                iras_frame = normalized_joint_locations(:,:,ira_frame);
                                contador = 1;
                                for ira_col=1:20
                                    col = iras_frame(:,ira_col);
                                    transformed = col';
                                    iras_final_normalize_joint(ira_frame,contador:contador+2) = transformed;
                                    contador = contador +3;
                                end
                            end
%                             filename = strcat('action_a',num2str(a),'_subject_s',num2str(s),'_instance_',num2str(e),'.txt');
%                             dlmwrite(filename, iras_final_normalize_joint,' ');
                            % END IRATI
                            
                            
                        end

                        skeletal_data{a, s, e}.action = a;
                        skeletal_data{a, s, e}.subject = s;
                        skeletal_data{a, s, e}.instance = e;
                    end                
                end
            end
        end

        save([dataset, '/skeletal_data'], 'skeletal_data', 'skeletal_data_validity');


    elseif (strcmp(dataset, 'Florence3D'))

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
            end

            frame_validity = (frame_validity == 1);

            normalized_joint_locations = normalized_joint_locations(:,:,frame_validity);        
            time_stamps = time_stamps(frame_validity);

            normalized_joint_locations = rotate_the_skeletons(normalized_joint_locations, body_model);

             % IRATI's CODE TO STORE THE NORMALIZED DATA IN
            % A DESIRABLE FORMAT
            iras_final_normalize_joint = zeros(n_frames,45);
            for ira_frame=1:size(normalized_joint_locations,3)
                iras_frame = normalized_joint_locations(:,:,ira_frame);
                contador = 1;
                for ira_col=1:15
                    col = iras_frame(:,ira_col);
                    transformed = col';
                    iras_final_normalize_joint(ira_frame,contador:contador+2) = transformed;
                    contador = contador +3;
                end
            end
            filename = strcat('action_a',num2str(unique(action_id(ind))),'_subject_s',num2str(unique(actor_id(ind))), '_i_', num2str(i),'.txt');
            dlmwrite(filename, iras_final_normalize_joint,' ');
                          
                          
            skeletal_data{i}.original_skeletal_data = original_skeletal_data;
            skeletal_data{i}.joint_locations = normalized_joint_locations;
            skeletal_data{i}.time_stamps = time_stamps;
            skeletal_data{i}.subject = unique(actor_id(ind));
            skeletal_data{i}.action = unique(action_id(ind));

        end       

        save([dataset, '/skeletal_data'], 'skeletal_data');

    else
        error('Unknwon dataset');
    end


end
