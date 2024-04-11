clc,close all
clear
cd SARImageFile\
cd SARImageData\
FixedImage = imread('1999.04.bmp');
MovingImage = imread("1999.05.bmp");

figure;
subplot(121)
imshow(FixedImage)
title("Fix Image")

subplot(122)
title("MovingImage")
imshow(MovingImage)

[optimizer, metric] = imregconfig('monomodal');
registeredImage = imregister(MovingImage, FixedImage, 'rigid', optimizer, metric);



