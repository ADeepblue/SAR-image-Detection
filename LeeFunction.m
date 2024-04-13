function [Image_Cofiltered] = LeeFunction(ImagePath)
%LEEFUNCTION 此处显示有关此函数的摘要
%   此处显示详细说明

Image = imread(ImagePath);

figure
imshow(Image);
title("origin Image")

[l,w,~]=size(Image);

windowlength = 7; %must be a single num
Onesidelength = floor(windowlength/2);
Image_Cofiltered = zeros(l-2*Onesidelength,w-2*Onesidelength);

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

end

