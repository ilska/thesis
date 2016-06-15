% Florence3D Database

%% File to launch the classification having the paths of the train test data

clc
clear
close all
addpath('./LDMLT_TS')

path_origin = 'C:/Users/ilska/Box Sync/Thesis Experiments/Data/Florence3D/joint_angles_quaternions/train_test_data/';
path_results = 'C:/Users/ilska/Box Sync/Thesis Experiments/Results/Florence3D/raw_data_results/joint_angles_quaternions/';
number_of_combinations = 10;

%training params
tripletsfactor = 20; % era 20
cycle = 1;
alphafactor = 5;% era 5;
Final_stats = [];
for i = 10:number_of_combinations
    
    str_train_data = strcat(path_origin,'train_data',num2str(i),'.mat');
    str_train_labels = strcat(path_origin,'train_labels',num2str(i),'.mat');
    str_test_data = strcat(path_origin,'test_data',num2str(i),'.mat');
    str_test_labels = strcat(path_origin,'test_labels',num2str(i),'.mat');

    TRAIN_X = load(str_train_data, '-mat');
    SNames = fieldnames(TRAIN_X); 
    TRAIN_X = TRAIN_X.(SNames{1});
    
    TRAIN_Y = load(str_train_labels);
    SNames = fieldnames(TRAIN_Y); 
    TRAIN_Y = TRAIN_Y.(SNames{1});
    
    TEST_X = load(str_test_data);
    SNames = fieldnames(TEST_X); 
    TEST_X = TEST_X.(SNames{1});
    
    TEST_Y = load(str_test_labels);
    SNames = fieldnames(TEST_Y); 
    TEST_Y = TEST_Y.(SNames{1});
    
    
    %% set parameters

    max_knn=1;  % The maximum number of number of neighbors in KNN algorithm. 
    params.tripletsfactor= tripletsfactor; %20     % (quantity of triplets in each cycle) = params.tripletsfactor x (quantity of training instances)
    params.cycle= cycle;%15;              % the maximum cycle 
    params.alphafactor= alphafactor;%5         % alpha = params.alphafactor/(quantity of triplets in each cycle)
    %% Perforamce Evaluation

    [W,L] = size(TRAIN_X);
    if (L ~= length(TRAIN_Y)),
       disp('ERROR: num rows of X must equal length of y');
       return;
    end

    %train the classifier
    M=LDMLT_TS(TRAIN_X,TRAIN_Y,params);
    K_vector=1:max_knn;

    %predict the results
    [Prediction,All_distances,Distance_2closest_class]= KNN_TS_irati(TRAIN_X,TRAIN_Y,TEST_X, M, K_vector); 

    statistics = confusionmatStats(TEST_Y,Prediction,All_distances,Distance_2closest_class);
    dir = strcat(path_results,'results/tripletsfactor_',num2str(tripletsfactor), '_cycle_',num2str(cycle),'_alphafactor_',num2str(alphafactor),'/');
    mkdir(dir);
    results_path = strcat(dir,'ut_combination_',num2str(i),'_tripletsfactor_',num2str(tripletsfactor), '_cycle_',num2str(cycle),'_alphafactor_',num2str(alphafactor),'.mat');

    save(results_path,'statistics');
    
    stat_means = [statistics.mean_accuracy, statistics.mean_sensitivity, statistics.mean_specificity, statistics.mean_precision, statistics.mean_recall, statistics.mean_Fscore];
    
    Final_stats = [Final_stats; stat_means];

    classes = [1:10];
% fprintf('Begin computing confus,accuracy,numcorrect,precision,recall,F...\n');
% [confus,accuracy,numcorrect,precision,recall,F,PatN,MAP,NDCGatN]=compute_accuracy_F(TEST_Y,Prediction,classes)

end

%stat_means = [statistics.mean_accuracy, statistics.mean_sensitivity, statistics.mean_specificity, statistics.mean_precision, statistics.mean_recall, statistics.mean_Fscore];
final_results = struct('mean_accuracy', mean(Final_stats(:,1)),'mean_sensitivity',mean(Final_stats(:,2)),'mean_specificity',mean(Final_stats(:,3)),'mean_precision',mean(Final_stats(:,4)),'mean_recall',mean(Final_stats(:,5)),'mean_Fscore',mean(Final_stats(:,6)));
results_path = strcat(dir,'mean_statistics.mat');
save(results_path,'final_results');


SNames = fieldnames(final_results);
txt_results_path = strcat(dir,'mean_statistics.txt');
fid = fopen(txt_results_path,'w');
for a = 1:length(SNames)
    strng = SNames{a};
    value = final_results.(SNames{a});
    fprintf(fid, '%s  %f \n', strng,value);
end
fclose(fid);
