clc,clear,close all

Image1 = imread("SARImageFile\FilterImageFile\leefilterbeijing_A_1.jpg");
Image2 = imread("SARImageFile\FilterImageFile\leefilterbeijing_A_2.jpg");
CompareResult1 = Image1 ./ Image2;
CompareResult2 = Image2 ./ Image1;

%% figure

magnification = 50;

figure
subplot(223)
imshow(CompareResult1*magnification);
title("Image1/Image2")
disp(max(CompareResult2(:)))

subplot(224)
imshow(CompareResult2*magnification);
title("Image2/Image1")
disp(max(CompareResult2(:)))

subplot(221)
imshow(Image1);
title("Image1")

subplot(222)
imshow(Image2);
title("Image2")
