%% Author: Alfonso Domínguez, Tecnalia. Based on ROS DMP formulation
% Least Square Weigths
% weights =  dmp_lwr_batch leastSquareWeigths (fDomain, fTarget,nPoints,nBases,type)

function weights= leastSquareWeigths (fDomain, fTarget,nPoints,nBases,type)

if(strcmp(type,'fourier'))
    dMat=zeros(nPoints,nBases);
    yMat=zeros(nPoints,1);

    for i1=1:nPoints
        yMat(i1,1)=fTarget(i1);
        features=calcFeatures(fDomain(i1),nBases);
        for j=1:nBases
            dMat(i1,j)=features(j);
        end
    end

    w=inv(dMat'*dMat)*dMat'*yMat;

    for i1=1:nBases
        weights(i1)=w(i1,1);
    end
elseif(strcmp(type,'linear'))
    weights=zeros(1, nBases)
end

function features= calcFeatures(X,nBases)
    features = zeros(nBases,1);
    for i2=0:nBases-1
        features(i2+1)= cos(pi*i2*X);
    end
end

end

