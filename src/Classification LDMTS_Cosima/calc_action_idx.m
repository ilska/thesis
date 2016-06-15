function [ real_action ] = calc_action_idx( filename )
% function [ idx ] = calc_subject_idx( filename )
%   This function calculates the index of the subject
%   given the name of the file as imput

str10 = '10';

action = filename(1,9:10);

match10 = strcmpi(action,str10);

if (match10)
    real_action = '10';
else
    real_action = filename(1,9);
end
%real_user_int = str2num(real_user);
end

