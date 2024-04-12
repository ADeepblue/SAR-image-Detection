%% Wavefiltering
clc,clear,close all

cd SARImageFile\SARImageData\

Image = imread("B1.tif");

figure
imshow(Image);
title("origin Image")

[l,w,d]=size(Image);

windowlength = 7; %must be a single num
Onesidelength = windowlength/2;
Image_filtered = zeros(l-Onesidelength,w-Onesidelength);

Border = 2*Onesidelength;

parfor index1 = 1:(l-2*Onesidelength)
    Image_temp = Image;
    for index2 = 1:(w-2*Onesidelength)
        temp_window = Image_temp(index1:index1+2*Onesidelength);
        
        Average = mean(mean(temp_window));
        SD = std2(temp_window);

        % a = 1 - (SD^2-Average^2)/(2 * SD^2);
        a = 1/2 + (Average/SD)^2/2;

        %b = (SD^2-Average^2)/(2*SD^2);
        b = 1/2 - (Average/SD)^2/2;

        

    end
end
