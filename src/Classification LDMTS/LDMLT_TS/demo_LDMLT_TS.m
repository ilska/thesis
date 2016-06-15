clc
clear
close all
addpath('./LDMLT_TS')
addpath('./data')
disp('Loading data...');

load JapaneseVowels_TRAIN_X
load JapaneseVowels_TRAIN_Y
load JapaneseVowels_TEST_X
load JapaneseVowels_TEST_Y

TRAIN_X=JapaneseVowels_TRAIN_X;
TRAIN_Y=JapaneseVowels_TRAIN_Y;
TEST_X=JapaneseVowels_TEST_X;
TEST_Y=JapaneseVowels_TEST_Y;

%% set parameters
max_knn=5; 
%max_knn=10;  % The maximum number of number of neighbors in KNN algorithm. 

params.tripletsfactor= 20;      % (quantity of triplets in each cycle) = params.tripletsfactor x (quantity of training instances)
params.cycle= 15;              % the maximum cycle 
params.alphafactor= 5;         % alpha = params.alphafactor/(quantity of triplets in each cycle)
%% Perforamce Evaluation

[W,L] = size(TRAIN_X);
if (L ~= length(TRAIN_Y)),
   disp('ERROR: num rows of X must equal length of y');
   return;
end

M=LDMLT_TS(TRAIN_X,TRAIN_Y,params);
K_vector=1:max_knn;
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