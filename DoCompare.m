clc,clear,close all

Image1 = imread("SARImageFile\FilterImageFile\leefilterbeijing_A_1.jpg");
Image2 = imread("SARImageFile\FilterImageFile\leefilterbeijing_A_2.jpg");
CompareResult1 = Image1 ./ Image2;
CompareResult2 = Image2 ./ Image1;
CompareResult3 = Image1 -Image2;
CompareResult4 = Image2 -Image1;
%% figure

magnification = 50;

figure
subplot(233)
imshow(CompareResult1*magnification);
title("Image1/Image2")
disp(max(CompareResult2(:)))

subplot(234)
imshow(CompareResult2*magnification);
title("Image2/Image1")


subplot(231)
imshow(Image1);
title("Image1")

subplot(232)
imshow(Image2);
title("Image2")

subplot(235)
imshow(CompareResult3*magnification);
title("Image1-Image2")


subplot(236)
imshow(CompareResult4*magnification);
title("Image2-Image1")

