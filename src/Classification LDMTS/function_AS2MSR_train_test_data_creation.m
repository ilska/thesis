
function function_AS2MSR_train_test_data_creation( load_files_path )


save_data_path = strcat(load_files_path,'AS2\train_test_data\');

dir_files_path = strcat(load_files_path,'*.txt');
files = dir(dir_files_path);


data_s1 = {};data_s2 = {};data_s3 = {};data_s4 = {};data_s5 = {};
data_s6 = {};data_s7 = {};data_s8 = {};data_s9 = {};data_s10 = {};
label_s1 = [];label_s2 = [];label_s3 = [];label_s4 = [];label_s5 = [];
label_s6 = [];label_s7 = [];label_s8 = [];label_s9 = [];label_s10 = [];
cont1 = 1; cont2 = 1;cont3=1; cont4 = 1; cont5 = 1; cont6 = 1; 
cont7 =1; cont8 = 1; cont9 = 1; cont10 = 1;
 for file = files'
    
    filename = file.name;
    path = strcat(load_files_path,filename);
    raw_data = load_file(path);
    
    [ action ] = calc_action_idx_MSR( filename );
    action = str2num(action);
    [ subject ] = calc_subject_idx_MSR( filename,action );
     %Action set 2
%  {[1 4 7 8 9 11 12 14]}
     if (action == 1 || action == 4 || action == 7 || action == 8 || action == 9 || action == 11 || action == 12 || action == 14  )
        if (subject == '1')
                    data_s1(1,cont1)= {raw_data};
                    label_s1(1,cont1) = action;
                    cont1 = cont1+1;
        elseif(subject == '2')
                    data_s2(1,cont2)= {raw_data};
                    label_s2(1,cont2)= action;
                    cont2 = cont2 +1;
        elseif(subject == '3')
                    data_s3(1,cont3)= {raw_data};
                    label_s3(1,cont3) = action;
                    cont3 = cont3 +1;   
        elseif(subject == '4')
                    data_s4(1,cont4)= {raw_data};
                    label_s4(1,cont4) = action;
                    cont4 = cont4 +1;
        elseif(subject == '5')
                    data_s5(1,cont5)= {raw_data};
                    label_s5(1,cont5) = action;
                    cont5 = cont5 +1;
        elseif(subject == '6')
                    data_s6(1,cont6)= {raw_data};
                    label_s6(1,cont6) = action;
                    cont6 = cont6+1;
        elseif(subject == '7')
                    data_s7(1,cont7)= {raw_data};
                    label_s7(1,cont7) = action;
                    cont7 = cont7 +1;
        elseif(subject == '8')
                    data_s8(1,cont8)= {raw_data};
                    label_s8(1,cont8) = action;
                    cont8 = cont8 +1;
        elseif(subject == '9')
                    data_s9(1,cont9)= {raw_data};
                    label_s9(1,cont9) = action;
                    cont9 = cont9+1;
        else
                    data_s10(1,cont10)= {raw_data};
                    label_s10(1,cont10) =  action;
                    cont10 = cont10+1;
        end 
    end
 end 
 
 mkdir (save_data_path);

% Option1

train_data1 = [data_s3 data_s1 data_s10 data_s5 data_s2];
train_labels1 = [label_s3 label_s1 label_s10 label_s5 label_s2];
test_data1 = [data_s4 data_s6 data_s7 data_s8 data_s9];
test_labels1 = [label_s4 label_s6 label_s7 label_s8 label_s9];

save((strcat(save_data_path,'train_data1.mat')),'train_data1');
save((strcat(save_data_path,'train_labels1.mat')),'train_labels1');
save((strcat(save_data_path,'test_data1.mat')),'test_data1');
save((strcat(save_data_path,'test_labels1.mat')),'test_labels1');

%Option 2
train_data2 = [data_s10 data_s5 data_s2 data_s4 data_s3];
train_labels2 = [label_s10 label_s5 label_s2 label_s4 label_s3];
test_data2 = [data_s1 data_s6 data_s7 data_s8 data_s9];
test_labels2 = [label_s1 label_s6 label_s7 label_s8 label_s9];

save((strcat(save_data_path,'train_data2.mat')),'train_data2');
save((strcat(save_data_path,'train_labels2.mat')),'train_labels2');
save((strcat(save_data_path,'test_data2.mat')),'test_data2');
save((strcat(save_data_path,'test_labels2.mat')),'test_labels2');

%Option 3

train_data3 = [data_s3 data_s5 data_s6 data_s2 data_s7];
train_labels3 = [label_s3 label_s5 label_s6 label_s2 label_s7];
test_data3 = [data_s1 data_s4 data_s8 data_s9 data_s10];
test_labels3 = [label_s1 label_s4 label_s8 label_s9 label_s10];
 
save((strcat(save_data_path,'train_data3.mat')),'train_data3');
save((strcat(save_data_path,'train_labels3.mat')),'train_labels3');
save((strcat(save_data_path,'test_data3.mat')),'test_data3');
save((strcat(save_data_path,'test_labels3.mat')),'test_labels3');

%Option 4

train_data4 = [data_s5 data_s6 data_s8 data_s3 data_s2];
train_labels4 = [label_s5 label_s6 label_s8 label_s3 label_s2];
test_data4 = [data_s1 data_s4 data_s7 data_s9 data_s10];
test_labels4 = [label_s1 label_s4 label_s7 label_s9 label_s10];

save((strcat(save_data_path,'train_data4.mat')),'train_data4');
save((strcat(save_data_path,'train_labels4.mat')),'train_labels4');
save((strcat(save_data_path,'test_data4.mat')),'test_data4');
save((strcat(save_data_path,'test_labels4.mat')),'test_labels4');

%Option 5

train_data5 = [data_s6 data_s3 data_s5 data_s2 data_s9];
train_labels5 = [label_s6 label_s3 label_s5 label_s2 label_s9];
test_data5 = [data_s1 data_s4 data_s7 data_s8 data_s10];
test_labels5 = [label_s1 label_s4 label_s7 label_s8 label_s10];

save((strcat(save_data_path,'train_data5.mat')),'train_data5');
save((strcat(save_data_path,'train_labels5.mat')),'train_labels5');
save((strcat(save_data_path,'test_data5.mat')),'test_data5');
save((strcat(save_data_path,'test_labels5.mat')),'test_labels5');

%Option 6

train_data6 = [data_s3 data_s5 data_s2 data_s10 data_s6];
train_labels6 = [label_s3 label_s5 label_s2 label_s10 label_s6];
test_data6 = [data_s1 data_s4 data_s7 data_s8 data_s9];
test_labels6 = [label_s1 label_s4 label_s7 label_s8 label_s9];


save((strcat(save_data_path,'train_data6.mat')),'train_data6');
save((strcat(save_data_path,'train_labels6.mat')),'train_labels6');
save((strcat(save_data_path,'test_data6.mat')),'test_data6');
save((strcat(save_data_path,'test_labels6.mat')),'test_labels6');

%Option 7

train_data7 = [data_s2 data_s7 data_s5 data_s3 data_s8];
train_labels7 = [label_s2 label_s7 label_s5 label_s3 label_s8];
test_data7 = [data_s1 data_s4 data_s6 data_s9 data_s10];
test_labels7 = [label_s1 label_s4 label_s6 label_s9 label_s10];

save((strcat(save_data_path,'train_data7.mat')),'train_data7');
save((strcat(save_data_path,'train_labels7.mat')),'train_labels7');
save((strcat(save_data_path,'test_data7.mat')),'test_data7');
save((strcat(save_data_path,'test_labels7.mat')),'test_labels7');

%Option 8

train_data8 = [data_s2 data_s7 data_s9 data_s5 data_s3];
train_labels8 = [label_s2 label_s7 label_s9 label_s5 label_s3];
test_data8 = [data_s1 data_s4 data_s6 data_s8 data_s10];
test_labels8 = [label_s1 label_s4 label_s6 label_s8 label_s10];

save((strcat(save_data_path,'train_data8.mat')),'train_data8');
save((strcat(save_data_path,'train_labels8.mat')),'train_labels8');
save((strcat(save_data_path,'test_data8.mat')),'test_data8');
save((strcat(save_data_path,'test_labels8.mat')),'test_labels8');

%Option 9

train_data9 = [data_s2 data_s10 data_s5 data_s8 data_s3];
train_labels9 = [label_s2 label_s10 label_s5 label_s8 label_s3];

test_data9 = [data_s1 data_s4 data_s6 data_s7 data_s9];
test_labels9 = [label_s1 label_s4 label_s6 label_s7 label_s9];

save((strcat(save_data_path,'train_data9.mat')),'train_data9');
save((strcat(save_data_path,'train_labels9.mat')),'train_labels9');
save((strcat(save_data_path,'test_data9.mat')),'test_data9');
save((strcat(save_data_path,'test_labels9.mat')),'test_labels9');

%Option 10

train_data10 = [data_s3 data_s2 data_s5 data_s9 data_s10];
train_labels10 = [label_s3 label_s2 label_s5 label_s9 label_s10];
test_data10 = [data_s1 data_s4 data_s6 data_s7 data_s8];
test_labels10 = [label_s1 label_s4 label_s6 label_s7 label_s8];

save((strcat(save_data_path,'train_data10.mat')),'train_data10');
save((strcat(save_data_path,'train_labels10.mat')),'train_labels10');
save((strcat(save_data_path,'test_data10.mat')),'test_data10');
save((strcat(save_data_path,'test_labels10.mat')),'test_labels10');





% %Guardamos por usuario los datos y los labels
save((strcat(save_data_path,'data_s1.mat')),'data_s1');
save((strcat(save_data_path,'label_s1.mat')),'label_s1');

save((strcat(save_data_path,'data_s2.mat')),'data_s2');
save((strcat(save_data_path,'label_s2.mat')),'label_s2');

save((strcat(save_data_path,'data_s3.mat')),'data_s3');
save((strcat(save_data_path,'label_s3.mat')),'label_s3');

save((strcat(save_data_path,'data_s4.mat')),'data_s4');
save((strcat(save_data_path,'label_s4.mat')),'label_s4');

save((strcat(save_data_path,'data_s5.mat')),'data_s5');
save((strcat(save_data_path,'label_s5.mat')),'label_s5');

save((strcat(save_data_path,'data_s6.mat')),'data_s6');
save((strcat(save_data_path,'label_s6.mat')),'label_s6');

save((strcat(save_data_path,'data_s7.mat')),'data_s7');
save((strcat(save_data_path,'label_s7.mat')),'label_s7');

save((strcat(save_data_path,'data_s8.mat')),'data_s8');
save((strcat(save_data_path,'label_s8.mat')),'label_s8');

save((strcat(save_data_path,'data_s9.mat')),'data_s9');
save((strcat(save_data_path,'label_s9.mat')),'label_s9');

save((strcat(save_data_path,'data_s10.mat')),'data_s10');
save((strcat(save_data_path,'label_s10.mat')),'label_s10');

end 
 
 
 