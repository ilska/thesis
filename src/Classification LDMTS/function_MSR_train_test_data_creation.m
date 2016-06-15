
function function_MSR_train_test_data_creation( load_files_path )


save_data_path = strcat(load_files_path,'train_test_data\');

dir_files_path = strcat(load_files_path,'*.txt');
files = dir(dir_files_path);


data_s1 = {};data_s2 = {};data_s3 = {};data_s4 = {};data_s5 = {};
data_s6 = {};data_s7 = {};data_s8 = {};data_s9 = {};data_s10 = {};
label_s1 = [];label_s2 = [];label_s3 = [];label_s4 = [];label_s5 = [];
label_s6 = [];label_s7 = [];label_s8 = [];label_s9 = [];label_s10 = [];
cont1 = 1; cont2 = 1;cont3=1; cont4 = 1; cont5 = 1; cont6 = 1; 
cont7 =1; cont8 = 1; cont9 = 1; cont10 = 1;
 for file = files'
    
    filename = file.name
    path = strcat(load_files_path,filename);
    raw_data = load_file(path);
    
    [ action ] = calc_action_idx( filename )
    action = str2num(action);
    [ subject ] = calc_subject_idx( filename,action )
    
     
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
                    label_s8(1,cont8) = action
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
 

 
 % Action set 1
 {[2 3 5 6 10 13 18 20]}
 %  train subjects
    [3 1 10 5 2
    ;10 5 2 4 3
    ;3 5 6 2 7
    ;5 6 8 3 2
    ;6 3 5 2 9
    ;3 5 2 10 6
    ;2 7 5 3 8
    ;2 7 9 5 3
    ;2 10 5 8 3
    ;3 2 5 9 10]

% Test subject
[4 6 7 8 9;
    1 6 7 8 9;
    1 4 8 9 10;
    1 4 7 9 10;
    1 4 7 8 10;
    1 4 7 8 9;
    1 4 6 9 10;
    1 4 6 8 10;
    1 4 6 7 9
    ;1 4 6 7 8]


 
 %Action set 2
 {[1 4 7 8 9 11 12 14]}
 
 %  train subjects
    [3 1 10 5 2
    ;10 5 2 4 3
    ;3 5 6 2 7
    ;5 6 8 3 2
    ;6 3 5 2 9
    ;3 5 2 10 6
    ;2 7 5 3 8
    ;2 7 9 5 3
    ;2 10 5 8 3
    ;3 2 5 9 10]

% Test subject
[4 6 7 8 9;
    1 6 7 8 9;
    1 4 8 9 10;
    1 4 7 9 10;
    1 4 7 8 10;
    1 4 7 8 9;
    1 4 6 9 10;
    1 4 6 8 10;
    1 4 6 7 9
    ;1 4 6 7 8]
 
 %Action set 3
 {[6 14 15 16 17 18 19 20]}
 
 %  train subjects
    [3 1 10 5 2
    ;10 5 2 4 3
    ;3 5 6 2 7
    ;5 6 8 3 2
    ;6 3 5 2 9
    ;3 5 2 10 6
    ;2 7 5 3 8
    ;2 7 9 5 3
    ;2 10 5 8 3
    ;3 2 5 9 10]

% Test subject
[4 6 7 8 9;
    1 6 7 8 9;
    1 4 8 9 10;
    1 4 7 9 10;
    1 4 7 8 10;
    1 4 7 8 9;
    1 4 6 9 10;
    1 4 6 8 10;
    1 4 6 7 9
    ;1 4 6 7 8]