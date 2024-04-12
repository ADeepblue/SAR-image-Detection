%% corase Wavefiltering

clc,clear,close all

% cd SARImageFile\SARImageData\

Image = imread("yellow_C_1.bmp");

figure
imshow(Image);
title("origin Image")

[l,w,d]=size(Image);

windowlength = 7; %must be a single num
Onesidelength = floor(windowlength/2);
Image_COfiltered = zeros(l-Onesidelength,w-Onesidelength);

Border = 2*Onesidelength;

for index1 = 1:(l-2*Onesidelength)
    for index2 = 1:(w-2*Onesidelength)

        temp_window = Image(index1:index1+2*Onesidelength,index2:index2+2*Onesidelength);
        
        Average = mean(temp_window(:));
        SD = std2(temp_window);


        %b = (SD^2-Average^2)/(2*SD^2);
        b = 1/2 - (Average/SD)^2/2;

        Image_COfiltered(index1,index2) = Average + b ...
        * (Image(index1+Onesidelength,index2+Onesidelength)-Average);

    end
end

figure
imshow(uint8(Image_COfiltered))
title("Lee filter")


%% Fine WaveFiltering

windowlength = 7;
Image_Fine_Filtered = zeros(l-Onesidelength,w-Onesidelength);
Core1 = [-1,0,1;
         -1,0,1;
         -1,0,1];

Core2 = [0,1,1;
        -1,0,1;
        -1,-1,0];

Core3 = [1,1,1;
         0,0,0;
        -1,-1,-1];

Core4 =[1,1,0;
        1,0,-1;
       0,-1,-1];


