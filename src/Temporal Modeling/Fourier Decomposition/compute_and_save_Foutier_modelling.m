

%function to calculate and save the DMP modelling
%filetype must be txt

function compute_and_save_Foutier_modelling(load_files_path, destination_path,n_coeffs,fixed_coeffs)%% Load the data





%   Get the files from the parent directory
dir_files_path = strcat(load_files_path,'*.txt');
files = dir(dir_files_path);
   
 for file = files'
    
    filename = file.name;
    path = strcat(load_files_path,filename);
    raw_data = load_file(path);
    raw_data1 = raw_data;
    if ((raw_data(1,19)== 0 &&raw_data(1,20)== 0 && raw_data(1,21)== 0) || (raw_data(1,7)== 0 &&raw_data(1,8)== 0 && raw_data(1,9)== 0))
        if ((raw_data(1,19)== 0 &&raw_data(1,20)== 0 && raw_data(1,21)== 0) )
            raw_data = [raw_data(:,1:18) raw_data(:,22:end)];
        else
            raw_data = [raw_data(:,1:6) raw_data(:,10:end)];
        end
    else
        raw_data = raw_data(:,:);
    end

    % Fourier modelling
    if (fixed_coeffs == 'no')
        %if fixed coeffs = false, then take the size of the time series as
        %the coeff and
        n_coeffs = size(raw_data,1);
        % create the destination folder
        destination_path2 = strcat(destination_path, 'no_fixed_coeff_series','\')
        mkdir(destination_path2);
    else
        % create the destination folder
        destination_path2 = strcat(destination_path, 'n_coeffs',int2str(n_coeffs),'\')
        mkdir(destination_path2);
    end


    [fourier_coeffs_lf] =  get_fourier_coeffs_pyramid(raw_data, n_coeffs);
    fourier_coeffs_lf = fourier_coeffs_lf';
    %angles quantized and normalized KE
    saving_path = strcat(destination_path2,filename);
    dlmwrite(saving_path,fourier_coeffs_lf, ' ');
    
    
end