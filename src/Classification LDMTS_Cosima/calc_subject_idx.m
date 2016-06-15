function [ real_subject ] = calc_subject_idx( filename,action_idx )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if (action_idx == 10)
    subject = filename(1,21:22);
else
    subject = filename(1,20:21);
end
    
str1 = '1_'; str3 = '3_'; str5 = '5_'; str7 = '7_'; str9 = '9_';
str2 = '2_'; str4 = '4_'; str6 = '6_'; str8 = '8_'; str10 = '10';

match1 = strcmpi(subject,str1); match2 = strcmpi(subject,str2);
match3 = strcmpi(subject,str3); match4 = strcmpi(subject,str4);
match5 = strcmpi(subject,str5); match6 = strcmpi(subject,str6);
match7 = strcmpi(subject,str7); match8 = strcmpi(subject,str8);
match9 = strcmpi(subject,str9); match10 = strcmpi(subject,str10);

if (match10)
    real_subject = 10;
elseif(match9)
    real_subject = 9;
elseif(match8)
    real_subject = 8;
elseif(match7)
    real_subject = 7;
elseif(match6)
    real_subject = 6;
elseif(match5)
    real_subject = 5;
elseif(match4)
    real_subject = 4;
elseif(match3)
    real_subject = 3;
elseif(match2)
    real_subject = 2;  
else
    real_subject = 1;   
end

real_subject = num2str(real_subject);
% real_action_int = str2num(real_action);

end

