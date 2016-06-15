function compute_and_save_baseline_removal_and_rescaling( load_files_path, destination_path )

%function to calculate and save the kinetic energy of the joints combined
%with the angles respect to the torso.
%filetype must be txt
mkdir(destination_path);

%   Get the files from the parent directory
dir_files_path = strcat(load_files_path,'*.txt');
files = dir(dir_files_path);


 for file = files'
    
    filename = file.name;
    path = strcat(load_files_path,filename);
    raw_data = load_file(path);
    if ((raw_data(1,19)== 0 &&raw_data(1,20)== 0 && raw_data(1,21)== 0) || (raw_data(1,7)== 0 &&raw_data(1,8)== 0 && raw_data(1,9)== 0))
        if ((raw_data(1,19)== 0 &&raw_data(1,20)== 0 && raw_data(1,21)== 0) )
            raw_data = [raw_data(:,1:18) raw_data(:,22:end)];
        else
            raw_data = [raw_data(:,1:6) raw_data(:,10:end)];
        end
    else
        raw_data = raw_data(:,:);
    end

    % remove baseline and perform rescaling
    [ normalized_matrix ] = function_baselineremoval_rescaling( raw_data );
         
    %save
    saving_path = strcat(destination_path,filename);
    dlmwrite(saving_path,normalized_matrix, ' '); 
    

end

