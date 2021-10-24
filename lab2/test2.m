%% WEI YANG 21220208 Lab02 
%% Input Image
close all; clear; clc
I1 = imread('man.png');% input two images
I2 = imread('woman.png');
subplot(3,2,1); imshow(I1);title('Original Image 1 ');% Show Original Images
subplot(3,2,2); imshow(I2);title('Original Image 2 ');
%% Convert to grayscale image
Igray1=im2double(rgb2gray(I1)); %Convert images to grayscale and double precision
Igray2=im2double(rgb2gray(I2));
ff1 = fft2(Igray1); %computing 2D Fourier Transform 
ff2 = fft2(Igray2);
%% Smoothed Image
l=lowpassfilter([328,327],0.03,1); %call a lowpass filter set cut-off c value 0.03 and positive integer 1
L=l.*ff1; %smoothing with the lowpass filter in frequency domain
smooth=ifft2(L); % 2D inverse Fourier Transform to spacial domain
subplot(3,2,3); imshow(smooth);title('Smoothed Image');  %Show the smoothed image
%% Sharpened Image
h=highpassfilter([328,327],0.2,2);%call a highpass filter set cut-off c value 0.2 and positive integer 2
H=h.*ff2; %sharping with the lowpass filter in frequency domain
sharp=ifft2(H);% 2D inverse Fourier Transform to spacial domain
subplot(3,2,4); imshow(sharp);title('Sharpened Image ');%Show the sharpened image

%% Frequency Spectrum of smoothed Imag
ii1=fftshift(fft2(smooth)); 
subplot(3,2,5);imshow(ii1);title('Frequency Spectrum of smoothed Image');
%% Frequency Spectrum of Sharpened Image
ii2=fftshift(fft2(sharp));

subplot(3,2,6);imshow(ii2);title('Frequency Spectrum of Sharpened Image');
%% Final Hybrid Image 

final=ii1+ii2; % add two images together in frequency domain for hybird
final1=ifft2(ifftshift(final));%inverse FT to spacial domain
figure;
imshow(final1);title('Final Hybrid Image '); %Show the final result in a seperate pic

