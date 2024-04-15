

clc,clear,close all
tic
clear
cd SARImageFile\SARImageData\

FixedImage = imread("beijing_A_2.jpg");
MovingImage = imread('beijing_A_1.jpg');

% FixedImage = rgb2gray(FixedImage);
% MovingImage = rgb2gray(MovingImage);


% figure;
% subplot(121)
% imshow(FixedImage)
% title("Fix Image")
% 
% subplot(122)
% imshow(MovingImage)
% title("MovingImage")

[optimizer, metric] = imregconfig('monomodal');

[l,w,d] = size(FixedImage);

Isgray = 0;
if d == 1
Isgray = 1;
end

if Isgray
    registeredImage = zeros(l,w);
    registeredImage(:,:) = imregister(MovingImage(:,:), FixedImage(:,:), "translation", optimizer, metric);
else
    registeredImage = zeros(l,w,d);
for Deep = 1:1:3
registeredImage(:,:,Deep) = imregister(MovingImage(:,:,Deep), FixedImage(:,:,Deep), 'translation', optimizer, metric);
end
end

imwrite(uint8(registeredImage),"..\FilterImageFile\registerbeijing_A_1.jpg")

toc

cd ..\..

