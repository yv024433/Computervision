%% WEI YANG 21220208
%% Input Image
close all; clear; clc
Igray = imread('challenge.png');
imshow(Igray);
title('Input Image');

%% compute histogram
figure;
imhist(Igray);
title('Image Histogram')

%%  Binary Image (THRESHOLD 160 according to histogram)
bw=Igray>12;
figure;
imshow(bw);
title('Binary Image After  Thresholding')





