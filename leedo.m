%% corase Wavefiltering

clc,clear,close all

% cd SARImageFile\SARImageData\

Image = imread("SARImageFile\FilterImageFile\registerbeijing.jpg");
Image = rgb2gray(Image);
% figure
% imshow(Image);
% title("origin Image")

[l,w,~]=size(Image);

windowlength = 7; %must be a single num
Onesidelength = floor(windowlength/2);
Image_Cofiltered = zeros(l-2*Onesidelength,w-2*Onesidelength);

Border = 2*Onesidelength;

for index1 = 1:(l-2*Onesidelength)
    for index2 = 1:(w-2*Onesidelength)

        temp_window = Image(index1:index1+2*Onesidelength,index2:index2+2*Onesidelength);
        
        Average = mean(temp_window(:));
        SD = std2(temp_window);


        %b = (SD^2-Average^2)/(2*SD^2);
        b = 1/2 - (Average/SD)^2/2;

        Image_Cofiltered(index1,index2) = Average + b ...
        * (Image(index1+Onesidelength,index2+Onesidelength)-Average);

    end
end

% figure
% imshow(uint8(Image_Cofiltered))
% title("Lee filter")

imwrite(uint8(Image_Cofiltered),"SARImageFile\FilterImageFile\leefilterbeijing.jpg")
