function [ real_action ] = calc_action_idx_MSR( filename )
% function [ idx ] = calc_subject_idx( filename )
%   This function calculates the index of the subject
%   given the name of the file as imput

str = '_';

element = filename(1,11);

match10 = strcmpi(element,str);

if (match10)
    real_action = filename(1,9:10);
else
    real_action = filename(1,9);
end
%real_user_int = str2num(real_user);
end

