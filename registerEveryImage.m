clc,clear,close all

tic

Image1 = "1999.04.bmp";
Image1a = "1999.05.bmp";
ImageStruct = struct("OneImage",Image1,"AnotherImage",Image1a);
Image2 = "B1.tif";
Image2a = "B2.tif";
ImageStruct = [ImageStruct,struct("OneImage",Image2,"AnotherImage",Image2a)];
Image3 = "beijing_A_1.jpg";
Image3a = "beijing_A_2.jpg";
ImageStruct = [ImageStruct,struct("OneImage",Image3,"AnotherImage",Image3a)];
Image4 = "lake_1986.png";
Image4a = "lake_1992.png";
ImageStruct = [ImageStruct,struct("OneImage",Image4,"AnotherImage",Image4a)];
Image5 = "yellow_C_1.bmp";
Image5a = "yellow_C_2.bmp";
ImageStruct = [ImageStruct,struct("OneImage",Image5,"AnotherImage",Image5a)];


for index = 1:length(ImageStruct)
    output = uint8(RegistrationFunction("SARImageFile\SARImageData\"+ImageStruct(index).OneImage,"SARImageFile\SARImageData\"+ImageStruct(index).AnotherImage));
    imwrite(output,"SARImageFile\FilterImageFile\register"+ImageStruct(index).OneImage)
end

toc