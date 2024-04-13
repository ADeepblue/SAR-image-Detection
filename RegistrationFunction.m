function [registeredImage] = RegistrationFunction(ImagePath1,ImagePath2)
%REGISTRATIONFUNCTION 此处显示有关此函数的摘要
%   此处显示详细说明

FixedImage = imread(ImagePath1);
MovingImage = imread(ImagePath2);

% FixedImage = rgb2gray(FixedImage);
% MovingImage = rgb2gray(MovingImage);

[optimizer, metric] = imregconfig('monomodal');

[l,w,d] = size(FixedImage);

registeredImage = zeros(l,w,d);
for Deep = 1:1:3
registeredImage(:,:,Deep) = imregister(MovingImage(:,:,Deep), FixedImage(:,:,Deep), 'rigid', optimizer, metric);
end


end

