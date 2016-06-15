clear all
close all
clc

%load the data
load('OriginalUT.mat');

dataset = 'UTKinect'; % 20 joints in this case

% Original
% joints_order = [5, 9, 3, 2, 13, 17, 1, 6, 10, 7, 11, 8, 12, 14, 18, 15, 19, 16, 20, 4];
% joints_order = [];

time_instant = OriginalUT(1,:);

% separate the joints into a cell

for i=1:3:57
    point = time_instant(1,i:i+3);
    xlabel('x-axis')
    ylabel('y-axis')
    zlabel('z-axis')
    scatter3(point(1,1),point(1,3),point(1,2));
    hold on;


end