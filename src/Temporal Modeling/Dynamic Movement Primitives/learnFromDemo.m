%% Author: Alfonso Domínguez, Tecnalia
% Learn a trajectory from a demo using Least Squared Weight Regression (following ROS implementation of DMP) or Locally Weighted Regression (LWR) 
function [dmpList,demoTraj]=learnFromDemo (demoTraj,kGains, dGains, numBases,type,centers,widths, alpha)
    %type is a parameter that indicates which indicates the type of
    %approximation that must be used for extracting weights
    numberPoints= size(demoTraj.positions,2);

    % if no vector is provided for velocities and accelerations,
    % estimate them from positions vector    
    if(demoTraj.velocities == 0 || demoTraj.accelerations == 0)
        demoTraj.velocities=zeros(size(demoTraj.positions,1), numberPoints);
        demoTraj.accelerations=zeros(size(demoTraj.positions,1), numberPoints);
        estimate=1;
    else
        estimate=0;
    end

    for d=1:size(demoTraj.positions,1)
        x0=demoTraj.positions(d,1);
        goal=demoTraj.positions(d,numberPoints);
        currK = kGains(d);
        currD = dGains(d);
        tau=demoTraj.times(numberPoints);

        xDemo=zeros(1,numberPoints);
        xDemo(1)= demoTraj.positions(d,1);
        vDemo=zeros(1,numberPoints);
        vDotDemo=zeros(1,numberPoints);

        if(estimate == 1)
            %calculate v and v dot (acc) assuming constant acceleration
            for i=2:numberPoints
                xDemo(i)=demoTraj.positions(d,i);
                dx=xDemo(i)-xDemo(i-1);
                dt=demoTraj.times(i)-demoTraj.times(i-1);
                vDemo(i)=dx/dt;
                vDotDemo(i)=(vDemo(i)-vDemo(i-1))/dt;
            end
            demoTraj.velocities(d,:)=vDemo;
            demoTraj.accelerations(d,:)=vDotDemo;
        end

        %Calculate the target pairs
        fDomain=zeros(1,numberPoints);
        fTarget=zeros(1,numberPoints);
        phaseVector=zeros(1,numberPoints);

        %solve for weigths
        if(strcmp(type,'fourier') ||strcmp(type,'linear'))
            for i=1:numberPoints
                currTime = demoTraj.times(i);
                phase=exp(-alpha*currTime/tau);
                phaseVector(i)=phase;
                fDomain(i)=demoTraj.times(i)/tau; %scaled time is cleaner than phase for spacing reasons
                fTarget(i)=((tau*tau*vDotDemo(i)+currD*tau*vDemo(i))/currK)-(goal-xDemo(i))+((goal-x0)*phase); % I think this is wrong(Formula 8) This is not the original formulations and its intention is to solve three erroros detected in the original formulation (see point IIb in the paper)
                %fTarget(i)=((tau*vDotDemo(i)+currD*vDemo(i))/currK)-(goal-xDemo(i))+((goal-x0)*phase); % (Formula 8) This is not the original formulations and its intention is to solve three erroros detected in the original formulation (see point IIb in the paper)
                fTarget(i) = fTarget(i)/phase; %Do this instead of having fcn approx scale its output based on phase
            end
            weightsVector = leastSquareWeights(fDomain,fTarget,numberPoints,numBases,type);
            psiMat=0;
        elseif(strcmp(type,'lwr'))
            for i=1:numberPoints
                currTime = demoTraj.times(i);
                phase=exp(-alpha*currTime/tau);
                phaseVector(i)=phase;
                fDomain(i)=demoTraj.times(i)/tau; %scaled time is cleaner than phase for spacing reasons
                fTarget(i)=((tau*vDotDemo(i)+currD*vDemo(i))/currK)-(goal-xDemo(i))+((goal-x0)*phase); % (Formula 8) This is not the original formulations and its intention is to solve three erroros detected in the original formulation (see point IIb in the paper)
            end
            [psiMat,weightsVector] = locallyWeigthedRegression(fTarget,phaseVector,numBases,centers,widths,demoTraj.positions(d,size(demoTraj.positions,2)),demoTraj.positions(d,1));
        end

        %create structures
        dmpData.weights=weightsVector;
        dmpData.kGain=currK;
        dmpData.dGain=currD;
        dmpData.fDomain=zeros(1, numberPoints);
        dmpData.fTarget=zeros(1, numberPoints);
        for i=1:numberPoints
            dmpData.fDomain(i)=fDomain(i);
            dmpData.fTarget(i)=fTarget(i);
        end
        dmpData.tau=tau;
        dmpData.psi=psiMat;
        dmpList(d)=dmpData;
    end
end