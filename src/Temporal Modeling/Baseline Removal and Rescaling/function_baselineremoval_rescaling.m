function [ normalized_matrix ] = function_baselineremoval_rescaling( imput_data )

% This function will normalize every column of the matrix. 
% based on this function: A' = (A-mean(A))/std(A)

	[RR, CC]  = size (imput_data);
	normalized_matrix = [];
	for columns=1:CC
		vector = imput_data(:,columns);
		mean_val = mean(vector);
		std_val = std(vector);
		% MIRAR EN EL PAPER SONDE PONEN EL PUNTO PARA Q ESTO SEA UN ENTERO
        if (std_val == 0)
            new_col = vector;
        else
            new_col = (vector-mean_val)/std_val;
        end
		normalized_matrix = [normalized_matrix new_col];
	end
end

