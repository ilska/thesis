

%function to calculate and save the DMP modelling
%filetype must be txt

function compute_and_save_DMP_modelling(load_files_path, destination_path,frame_frec,numGausians,typeApproximation)%% Load the data

% create the destination folder
destination_path = strcat(destination_path, 'typeApproximation_',typeApproximation ,'_frame_frec_',num2str(frame_frec),'_numGausians_',int2str(numGausians),'\')
mkdir(destination_path);

%   Get the files from the parent directory
dir_files_path = strcat(load_files_path,'*.txt');
files = dir(dir_files_path);
   
 for file = files'
    
    filename = file.name;
    path = strcat(load_files_path,filename);
    raw_data = load_file(path);

    % DMP modelling
    if ((raw_data(1,19)== 0 &&raw_data(1,20)== 0 && raw_data(1,21)== 0) || (raw_data(1,7)== 0 &&raw_data(1,8)== 0 && raw_data(1,9)== 0))
        if ((raw_data(1,19)== 0 &&raw_data(1,20)== 0 && raw_data(1,21)== 0) )
            raw_data = [raw_data(:,1:18) raw_data(:,22:end)];
        else
            raw_data = [raw_data(:,1:6) raw_data(:,10:end)];
        end
    else
        raw_data = raw_data(:,:);
    end
    
    [dmpList_xyz,dmp_matrix_xyz] = model_with_dmp(raw_data,size(raw_data,2),frame_frec,numGausians,typeApproximation);
        
       
    %angles quantized and normalized KE
    saving_path = strcat(destination_path,filename);
    dlmwrite(saving_path,dmp_matrix_xyz, ' ');
    
    
end