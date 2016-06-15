clear all
close all
clc


% 
% %for i=593:1050
%       str1 = int2str(i);
%       str = strcat('C:/Displayer/-/', str1, '.jpg');
%       img=imread(str);
%       outColor = imresize(img, [1536 2048]);
%       if i== 60
%           i
%       else
%          GrayImg = rgb2gray(outColor);
%       %figure, imshow(GrayImg);
%          str2 = strcat('C:/Displayer/Negativos/', str1, '.jpg');
%          imwrite(GrayImg,str2,'jpg');
%       end
%       
% %end;

 img=imread('C:/Displayer/-/60.jpg');
 outColor = imresize(img, [1536 2048]);
 GrayImg = rgb2gray(outColor);
 str2 = strcat('C:/Displayer/Negativos/60.jpg');
 imwrite(GrayImg,str2,'jpg');
 
  img=imread('C:/Displayer/-/582.jpg');
 outColor = imresize(img, [1536 2048]);
 GrayImg = rgb2gray(outColor);
 str2 = strcat('C:/Displayer/Negativos/582.jpg');
 imwrite(GrayImg,str2,'jpg');
 
  img=imread('C:/Displayer/-/592.jpg');
 outColor = imresize(img, [1536 2048]);
 GrayImg = rgb2gray(outColor);
 str2 = strcat('C:/Displayer/Negativos/592.jpg');
 imwrite(GrayImg,str2,'jpg');