
function [dmpList,dmp_vector] = model_with_dmp(action_data,dims,frame_frec, numGausians,typeApproximation)
    action_data = action_data';
    %% configurable parameters
    %dt=1.0; %time step
    %dt=0.33; %time step
    dt = frame_frec;
    K=100;
    D=2.0*sqrt(K);
    numBases = numGausians;
    alpha= -log(0.01); % ensures of convergence at t=tau
    typeApprox = typeApproximation;
    
%     numBases=15; % base number, increase this number in order to better adjust
    %typeApprox='linear';
    %typeApprox='fourier';
    %typeApprox='lwr';

    %% read my file

    demoTraj.positions = action_data;%([s_x s_y s_z]./1000.0)';
    demoTraj.velocities = 0;
    demoTraj.accelerations = 0;
    
%     dims=  95; %3; %dimension number

    % if type is lwr, then centers and deviations should be given. The 
    % centers or means belongs [0, 1] specify at which phase of the movement 
    % the basis function becomes active. They are typically equally spaced 
    % in the range of s and not modified during learning. The bandwidth of 
    % the basis functions is given by h and is typically chosen such that 
    % the Gaussians overlap.
    if(strcmp(typeApprox,'lwr'))
        tp = (0:1/(numBases-1):1);
        c = exp(-alpha*tp);
        sigma = (diff(c)*0.55);
        sigma = [sigma sigma(length(tp)-1)];
        h=1./(2*sigma.^2);
    else
        c=0;
        h=0;
    end

    kGains=ones(1,dims)*K;
    dGains=ones(1,dims)*D;
    numberPoints= size(demoTraj.positions,2);
    demoTimes=0:dt:(numberPoints-1)*dt;
    demoTraj.times = demoTimes;

    %figure('Name','Demo positions');
    %plot(demoTraj.times,demoTraj.positions);
    %title('Demo trajectory (Positions)');

    %% learn demo trajectory
    [dmpList,demoTraj]=learnFromDemo(demoTraj,kGains, dGains,numBases,typeApprox,c,h,alpha);
	
    dmp_vector = [];
    cols = size(action_data,1);
    
    for i=1:cols
        vec =  dmpList(i).weights;
        vec = vec';
        %vec = (vec-mean(vec))/std(vec);
	    dmp_vector = [dmp_vector vec];
    end