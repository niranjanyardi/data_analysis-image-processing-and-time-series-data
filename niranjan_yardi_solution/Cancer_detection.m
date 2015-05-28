clear all;
close all;
clc;

%uncomment this code block for 1st image set
%{
i1 = imread('C:\Users\ndy102\Downloads\case5-lcc.jpg');
i2 = imread('C:\Users\ndy102\Downloads\case5-rcc.jpg');
i22= i2(:,1000:end,:);
i11 = i1(:,1000:end,:);
i11=rgb2gray(i11);
i22=rgb2gray(i22);
%}

%uncomment this code block for 2nd image set
%{ 
i1 = imread('C:\Users\ndy102\Downloads\case181.jpg');
 i2 = imread('C:\Users\ndy102\Downloads\case182.jpg');
 i22= i2(:,1000:end);
 i11 = i1(:,1000:end);
%}

figure,imshow(i11);
figure,imshow(i22);
metric = registration.metric.MeanSquares;
optimizer = registration.optimizer.RegularStepGradientDescent() ;
moving_reg = imregister(i22,i11,'affine',optimizer,metric);
figure,imshowpair(i11, moving_reg,'diff');

        



