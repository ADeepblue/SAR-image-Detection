function [registeredImage] = RegistrationFunction(ImagePath1,ImagePath2)
    %REGISTRATIONFUNCTION 此处显示有关此函数的摘要
    %  ImagePath1 and ImagePath1 are all should be path texts
    %  registeredImage is a output double array


    FixedImage = imread(ImagePath1);
    MovingImage = imread(ImagePath2);

    % FixedImage = rgb2gray(FixedImage);
    % MovingImage = rgb2gray(MovingImage);

    [optimizer, metric] = imregconfig('monomodal');

    [l,w,d] = size(FixedImage);

    Isgray = 0;
    if d ==1
        Isgray = 1;
    end

    if Isgray
        registeredImage = zeros(l,w);
        registeredImage(:,:) = imregister(MovingImage(:,:), FixedImage(:,:), 'affine', optimizer, metric);
    else
        registeredImage = zeros(l,w,d);
        for Deep = 1:3
            registeredImage(:,:,Deep) = imregister(MovingImage(:,:,Deep), FixedImage(:,:,Deep), 'affine', optimizer, metric);
        end


    end

end

