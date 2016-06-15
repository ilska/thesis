function [Pred_Y,all_distances,Distance_2class] = KNN_TS_irati(X_train, Y_train, X_test, M, K_vector)

n_train= size(X_train,2);
n_test = size(X_test,2);


Y_kind=Y_train(1);
n=length(Y_train);
for i=2:n
    if sum(Y_kind==Y_train(i))==0
        Y_kind=[Y_train(i),Y_kind];
    end
end

% MODIFFY THIS IN ORDER TO HAVE THE DISTANCE TO THE CLASS TOO
all_distances = [];
for index_test=1:n_test
    for index_train=1:n_train
        [Dist,MTS_E1,MTS_E2]=dtw_metric(X_train{index_train},X_test{index_test},M);
        Distance(index_train)=Dist;
    end
    %en Distance están las distancias de esta muestra de test a todas las
    %muestras de train.
    
    [~, Inds] = sort(Distance,'ascend');
    for K_index=1:length(K_vector)
        K=K_vector(K_index);
        counts = zeros(1,length(Y_kind));
        for (j=1:K),
            place=find(Y_kind==Y_train(Inds(j)));
            counts(place) = counts(place) + 1/Y_train(Inds(j));
        end
        [~, v_p] = max(counts);
        Pred_Y(K_index,index_test)=Y_kind(v_p);
        Distance_2class(K_index,index_test) = Distance(Inds(1));
    end
    all_distances = [all_distances; Distance];
end

