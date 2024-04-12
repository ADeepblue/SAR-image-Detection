%% Wavefiltering
clc,clear,close all

cd SARImageFile\SARImageData\

Image = imread("B1.tif");

figure
imshow(Image);
title("origin Image")

[l,w,d]=size(Image);
