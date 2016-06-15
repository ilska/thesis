function [] = generate_features(directory, dataset, feature_type, n_desired_frames)
        
    load(['data/', dataset, '/skeletal_data'])
    load(['data/', dataset, '/body_model'])        

    if (strcmp(dataset, 'UTKinect'))
        n_subjects = 10;
        n_actions = 10;
        n_instances = 2;

        n_sequences = length(find(skeletal_data_validity));        

        features = cell(n_sequences, 1);
        action_labels = zeros(n_sequences, 1);
        subject_labels = zeros(n_sequences, 1);
        instance_labels = zeros(n_sequences, 1); 

        count = 1;
        for subject = 1:n_subjects
            for action = 1:n_actions
                for instance = 1:n_instances
                    if (skeletal_data_validity(action, subject, instance))                    

                        joint_locations = skeletal_data{action, subject, instance}.joint_locations;
                        %Code Irati has added
                        [aa,bb,cc]= size(skeletal_data{action, subject, instance}.joint_locations);
                        final_positions_no_inter = [];
                        for i=1:cc
                            instant_positions= [];
                            for j = 1:bb
                                singlej = skeletal_data{action, subject, instance}.joint_locations(:,j,i);
                                instant_positions = [instant_positions singlej'];
                            end
                            final_positions_no_inter = [final_positions_no_inter;instant_positions];
                        end
%                         %IRA save this: final_positions_no_inter
%                         directory1 = strcat(directory,'/skel_data/');
%                         mkdir(directory1)
%                         if (feature_type == 'absolute_joint_positions')
%                             filename = strcat(directory1,num2str(action),'_subject_s',num2str(subject),'_instance_',num2str(instance),'.txt');
%                             dlmwrite(filename, final_positions_no_inter,' ');
%                             %save the data
%                         end
                        features{count} = get_features(feature_type, joint_locations, body_model, n_desired_frames);
                        features_transposed = get_features(feature_type, joint_locations, body_model, n_desired_frames)';
                        %IRA save this: features_transposed
                        filename = strcat(directory,'/action_a',num2str(action),'_subject_s',num2str(subject),'_instance_',num2str(instance),'.txt');
                        dlmwrite(filename, features_transposed,' ');
                       
                        action_labels(count) = action;       
                        subject_labels(count) = subject;
                        instance_labels(count) = instance;

                        count = count + 1;
                    end
                end
            end
        end

        %save([directory, '/features'], 'features', '-v7.3');
        %save([directory, '/labels'], 'action_labels', 'subject_labels', 'instance_labels');

    elseif (strcmp(dataset, 'Florence3D'))    

        n_sequences = length(skeletal_data);

        features = cell(n_sequences, 1);
        action_labels = zeros(n_sequences, 1);
        subject_labels = zeros(n_sequences, 1);

        for count = 1:n_sequences      

            joint_locations = skeletal_data{count}.joint_locations;
            features{count} = get_features(feature_type, joint_locations, body_model, n_desired_frames);

            action_labels(count) = skeletal_data{count}.action;       
            subject_labels(count) = skeletal_data{count}.subject;        

        end

        save([directory, '/features'], 'features', '-v7.3');
        save([directory, '/labels'], 'action_labels', 'subject_labels');

        
    elseif (strcmp(dataset, 'MSRAction3D'))
                
        n_subjects = 10;
        n_actions = 20;
        n_instances = 3;

        n_sequences = length(find(skeletal_data_validity));        

        features = cell(n_sequences, 1);
        action_labels = zeros(n_sequences, 1);
        subject_labels = zeros(n_sequences, 1);
        instance_labels = zeros(n_sequences, 1); 

        count = 1;
        for subject = 1:n_subjects
            for action = 1:n_actions
                for instance = 1:n_instances
                    if (skeletal_data_validity(action, subject, instance))                    

                        joint_locations = skeletal_data{action, subject, instance}.joint_locations;        
                        features{count} = get_features(feature_type, joint_locations, body_model, n_desired_frames);
                        action_labels(count) = action;       
                        subject_labels(count) = subject;
                        instance_labels(count) = instance;

                        count = count + 1;
                    end
                end
            end
        end

        save([directory, '/features'], 'features', '-v7.3');
        save([directory, '/labels'], 'action_labels', 'subject_labels', 'instance_labels');        

    else    
        error('Unknown dataset');
    end
    
end

      
