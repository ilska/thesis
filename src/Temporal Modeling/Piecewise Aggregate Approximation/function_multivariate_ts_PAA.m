function [ PAA_activity ] = function_multivariate_ts_PAA( imput_data, alphabet_size,nsegments )

% This function will calculate SAX for a multivariate time serie
N = size(imput_data,1);%data_len = length(data);

% in the case of not interpolating the data, the spine coordinates are not
% removed from de files, so remove them otherwhise SAX crashes
if ((imput_data(1,19)== 0 &&imput_data(1,20)== 0 && imput_data(1,21)== 0) || (imput_data(1,7)== 0 &&imput_data(1,8)== 0 && imput_data(1,9)== 0))
    PAA_activity = zeros(nsegments,(size(imput_data,2)-3));
    if (imput_data(1,19)== 0 &&imput_data(1,20)== 0 && imput_data(1,21)== 0) 
        bodymodel = 1;
    end
    if (imput_data(1,7)== 0 &&imput_data(1,8)== 0 && imput_data(1,9)== 0)
        bodymodel = 2;
    end
    
else
    PAA_activity = zeros(nsegments,size(imput_data,2));
    bodymodel = 0; %for when the data is interpolated
end
cont = 1;
    for i = 1:size(imput_data,2)
        data = imput_data(:,i);
        [symbolic_data] =  timeseries2symbolPAA(data, N, nsegments, alphabet_size);
        PAA_vector = symbolic_data';
        % if we are not dealing with the spine coordinates
        if (bodymodel == 1)
            if (~(i == 19 || i == 20 || i == 21))
                PAA_activity(:,cont) = PAA_vector;
                cont = cont+1;
            end
        end
        if (bodymodel == 2)
            if (~(i == 7 || i == 8 || i == 9))
                PAA_activity(:,cont) = PAA_vector;
                cont = cont+1;
            end
        end
        if (bodymodel == 0)
            PAA_activity(:,cont) = PAA_vector;
                cont = cont+1;
        end
    end
    
    
end
