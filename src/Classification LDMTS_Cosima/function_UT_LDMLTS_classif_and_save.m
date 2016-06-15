function F = function_UT_LDMLTS_classif_and_save( path_origin , outpath,tripletsfactor,cycle,alphafactor)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%find the string UT_Kinect\ and copy everything behind that
pattern = '\UT_Kinect\';
k = strfind(path_origin,pattern);
str2crop = path_origin(1,k+11:end-17);
partial_resultpath = strcat(outpath,str2crop,'\trplt_',num2str(tripletsfactor), '_cycl_',num2str(cycle),'_alpha_',num2str(alphafactor),'\p_res.txt')
mean_resultpath = strcat(outpath,str2crop,'\trplt_',num2str(tripletsfactor), '_cycl_',num2str(cycle),'_alpha_',num2str(alphafactor),'\mean_results.txt')
folder_partial = strcat(outpath,str2crop,'\trplt_',num2str(tripletsfactor), '_cycl_',num2str(cycle),'_alpha_',num2str(alphafactor),'\')
mkdir(folder_partial);
number_of_combinations = 10;
Final_stats = [];

fid = fopen(partial_resultpath,'a+');

for i = 1:number_of_combinations
    
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
    params.alphafactor= alphafactor;%5         % alpha = params.alphafactor\(quantity of triplets in each cycle)
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
    
    %Guardar en el general lo de cada iteración + los mat + la media
    dir = strcat(folder_partial,'combination_',num2str(i),'.mat');
    save(dir,'statistics');
    
    fprintf(fid, 'combination %d \n',i);
    fprintf(fid, 'conf mat \n');
    
    matrix = statistics.confusionMat;
    for a = 1:size(matrix,1)
        for b = 1:size(matrix,2)
            value = matrix(a,b);
            fprintf(fid, '%d ',value);
        end
            fprintf(fid, '\n');
    end
    
    fprintf(fid, '\n specificity: ');
    matrix = (statistics.sensitivity)';
    for b = 1:size(matrix,2)
            value = matrix(1,b);
            fprintf(fid, '%f ',value);
    end
    fprintf(fid, '\n');
    
    fprintf(fid, '\n precision: ');
    matrix = (statistics.precision)';
    for b = 1:size(matrix,2)
            value = matrix(1,b);
            fprintf(fid, '%f ',value);
    end
    fprintf(fid, '\n');
    
    fprintf(fid, '\n recall: ');
    matrix = (statistics.recall)';
    for b = 1:size(matrix,2)
            value = matrix(1,b);
            fprintf(fid, '%f ',value);
    end
    fprintf(fid, '\n');


    fprintf(fid, '\n Fscore: ');
    matrix = (statistics.Fscore)';
    for b = 1:size(matrix,2)
            value = matrix(1,b);
            fprintf(fid, '%f ',value);
    end
    fprintf(fid, '\n');

    fprintf(fid, 'mean_accuracy: %f , mean_specificity: %f , mean_precision: %f, mean_recall: %f, mean_Fscore: %f  \n',statistics.mean_accuracy,statistics.mean_specificity,statistics.mean_precision,statistics.mean_recall,statistics.mean_Fscore);
    fprintf(fid, '-******- \n\n');
   
    stat_means = [statistics.mean_accuracy, statistics.mean_sensitivity, statistics.mean_specificity, statistics.mean_precision, statistics.mean_recall, statistics.mean_Fscore];
    
    Final_stats = [Final_stats; stat_means];

%     classes = [1:10];
% fprintf('Begin computing confus,accuracy,numcorrect,precision,recall,F...\n');
% [confus,accuracy,numcorrect,precision,recall,F,PatN,MAP,NDCGatN]=compute_accuracy_F(TEST_Y,Prediction,classes)

end

fclose(fid);
%stat_means = [statistics.mean_accuracy, statistics.mean_sensitivity, statistics.mean_specificity, statistics.mean_precision, statistics.mean_recall, statistics.mean_Fscore];
final_results = struct('mean_accuracy', mean(Final_stats(:,1)),'mean_sensitivity',mean(Final_stats(:,2)),'mean_specificity',mean(Final_stats(:,3)),'mean_precision',mean(Final_stats(:,4)),'mean_recall',mean(Final_stats(:,5)),'mean_Fscore',mean(Final_stats(:,6)));
results_path = strcat(folder_partial,'mean_stats.mat');
save(results_path,'final_results');

meanF = mean(Final_stats(:,6))

SNames = fieldnames(final_results);
fid2 = fopen(mean_resultpath,'w');
for a = 1:length(SNames)
    strng = SNames{a};
    value = final_results.(SNames{a});
    fprintf(fid2, '%s  %f \n', strng,value);
end
fclose(fid2);


mean_Fscore_printable = mean(Final_stats(:,6))
F = mean_Fscore_printable;






end

