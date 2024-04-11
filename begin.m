clc,close all
clear
cd SARImageFile\
cd SARImageData\
FixedImage = imread('1999.04.bmp');
MovingImage = imread("1999.05.bmp");

% FixedImage = rgb2gray(FixedImage);
% MovingImage = rgb2gray(MovingImage);


figure;
subplot(121)
imshow(FixedImage)
title("Fix Image")

subplot(122)
imshow(MovingImage)
title("MovingImage")

[optimizer, metric] = imregconfig('monomodal');

[l,w,d] = size(FixedImage);

registeredImage = zeros(l,w,d);
for Deep = 1:1:3
registeredImage(:,:,Deep) = imregister(MovingImage(:,:,Deep), FixedImage(:,:,Deep), 'rigid', optimizer, metric);
end


figure
imshow(uint8(registeredImage));
title("registeredImage")

cd ..
cd ..

