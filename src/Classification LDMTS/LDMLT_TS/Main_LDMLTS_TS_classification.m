%% File to launch the classification having the paths of the train test data

clc
clear
close all
addpath('./LDMLT_TS')
addpath('./data')
%addpath('C:/Users/ilska/Box Sync/Thesis Experiments/Data/MSRDailyActivity3D/Classification/Features/Selected_Joints_Relative_toSpine/AngleQuant_KineticE/')
addpath('C:/Users/ilska/Box Sync/Thesis Experiments/Data/UTKinect/absolute_joint_positions_interpolated/train_test_data/')



disp('Loading data...');

% load JapaneseVowels_TRAIN_X
% load JapaneseVowels_TRAIN_Y
% load JapaneseVowels_TEST_X
% load JapaneseVowels_TEST_Y
% 
% 
% TRAIN_X=JapaneseVowels_TRAIN_X;
% TRAIN_Y=JapaneseVowels_TRAIN_Y;
% TEST_X=JapaneseVowels_TEST_X;
% TEST_Y=JapaneseVowels_TEST_Y;




load train_data1;
load train_labels1;
load test_data1;
load test_labels1;
TRAIN_X = train_data1;
TRAIN_Y = train_labels1;
TEST_X = test_data1;
TEST_Y = test_labels1;
%% set parameters
 
max_knn=3;  % The maximum number of number of neighbors in KNN algorithm. 

params.tripletsfactor= 20;      % (quantity of triplets in each cycle) = params.tripletsfactor x (quantity of training instances)
params.cycle= 15;              % the maximum cycle 
params.alphafactor= 5;         % alpha = params.alphafactor/(quantity of triplets in each cycle)
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
pred= KNN_TS(TRAIN_X,TRAIN_Y,TEST_X, M, K_vector); 



%% result
for knn_size=1:min(max_knn)
    acc(knn_size) = sum(pred(knn_size,:)==TEST_Y)/length(TEST_Y);  
end

figure,plot(1:knn_size,acc*100,'-rs','LineWidth',2,'MarkerSize',5)
ylabel('Precision of Classfication (%)');
xlabel('Number of Neighbors');



Y_kind=sort(unique(TEST_Y),'ascend');
index=find(acc==max(acc));
error_matrix=zeros(length(Y_kind),length(Y_kind));
pred_test=pred(index(1),:);

for i=1:length(Y_kind)
    index_i=find(TEST_Y==Y_kind(i));
    for j=1:length(Y_kind)
        error_matrix(i,j)=sum(pred_test(index_i)==Y_kind(j));
    end
end
error_matrix