function [ SAX_activity ] = function_multivariate_ts_SAX( imput_data, alphabet_size,nsegments )

% This function will calculate SAX for a multivariate time serie
N = size(imput_data,1);%data_len = length(data);

% in the case of not interpolating the data, the spine coordinates are not
% removed from de files, so remove them otherwhise SAX crashes
if ((imput_data(1,19)== 0 &&imput_data(1,20)== 0 && imput_data(1,21)== 0) || (imput_data(1,7)== 0 &&imput_data(1,8)== 0 && imput_data(1,9)== 0))
    SAX_activity = zeros(nsegments,(size(imput_data,2)-3));
else
    SAX_activity = zeros(nsegments,size(imput_data,2));
end
cont = 1;
    for i = 1:size(imput_data,2)
        data = imput_data(:,i);
        [symbolic_data, pointers] =  timeseries2symbol(data, N, nsegments, alphabet_size);
        SAX_vector = symbolic_data';
        % if we are not dealing with the spine coordinates
        if (sum(SAX_vector) ~= 0)
            SAX_activity(:,cont) = SAX_vector;
            cont = cont+1;
        end
    end
    
    
end
