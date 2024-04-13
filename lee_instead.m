%% corase Wavefiltering

clc,clear,close all

% cd SARImageFile\SARImageData\

Image = imread("yellow_C_1.bmp");

figure
imshow(Image);
title("origin Image")

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

figure
imshow(uint8(Image_Cofiltered))
title("Lee filter")


%% Fine WaveFiltering

clc,clear,close all
% cd SARImageFile\SARImageData\

Image = imread("yellow_C_1.bmp");
[l,w,~]=size(Image);

windowlength = 7;
Onesidelength = floor(windowlength/2); 

Image_Fine_Filtered = zeros(l-2*Onesidelength,w-2*Onesidelength);
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

CoreTotal = zeros(3,3,3);
CoreTotal(1,:,:)=Core1;
CoreTotal(2,:,:)=Core2;
CoreTotal(3,:,:)=Core3;
CoreTotal(4,:,:)=Core4;

GV = linspace(0,0,4);
for index1 = 1+Onesidelength:l-Onesidelength
    for index2 = 1+Onesidelength:w-Onesidelength
        temp_window = Image(index1-Onesidelength:index1+Onesidelength,...
            index2-Onesidelength:index2+Onesidelength);

        M = zeros(3,3);
        for tempindex1 = 1:3
            for tempindex2 = 1:3
                M(tempindex1,tempindex2) = ...
                    mean(reshape(temp_window(2*tempindex1-1:2*tempindex1+1,2*tempindex2-1:2*tempindex2+1),1,[]));
            end
        end
        
        for tempindex = 1:4
            GV(tempindex) = sum(reshape(reshape(CoreTotal(tempindex,:,:),3,3).*M,1,[]));
        end

        [~,n] = max(GV);
        switch n
            case 1 %90
                if abs(M(2,1)-M(2,2)) > abs(M(2,3)-M(2,2))
                    temp_window = temp_window(:,4:7);
                else
                    temp_window = temp_window(:,1:4);
                end

            case 2 %135
                if abs(M(3,1)-M(2,2)) < abs(M(1,3)-M(2,2))
                    temp_window=[temp_window(1:7,1);temp_window(2:7,2);temp_window(3:7,3);temp_window(4:7,4);temp_window(5:7,5);temp_window(6:7,6);temp_window(7:7,7)];
                else
                    temp_window=[temp_window(1:1,1);temp_window(1:2,2);temp_window(1:3,3);temp_window(1:4,4);temp_window(1:5,5);temp_window(1:6,6);temp_window(1:7,7)];
                end

            case 3 %180
                if abs(M(1,2)-M(2,2)) < abs(M(3,2)-M(2,2))
                    temp_window = temp_window(4:7,:);
                else
                    temp_window = temp_window(1:4,:);
                end
            case 4 %45
                if abs(M(1,1)-M(2,2)) < abs(M(3,3)-M(2,2))
                    temp_window=[temp_window(1:7,1);temp_window(1:6,2);temp_window(1:5,3);temp_window(1:4,4);temp_window(1:3,5);temp_window(1:2,6);temp_window(1:1,7)];
                else
                    temp_window=[temp_window(7:7,1);temp_window(6:7,2);temp_window(5:7,3);temp_window(4:7,4);temp_window(3:7,5);temp_window(2:7,6);temp_window(1:7,7)];
                end
        end
        
        temp_window = temp_window(:);
        Average = mean(temp_window);
        SD = std2(temp_window);
        
        % a = 1-(SD2-Average^2)/(2*SD2);
        % a = 1/2 + (Average/SD)^2/2;
        
        b = (SD^2-Average^2)/(2*SD^2);
        Image_Fine_Filtered(index1-Onesidelength,index2-Onesidelength) = ...
            Average+b * (Image(index1,index2)-Average);
    end
end

clear tempindex1 tempindex2 tempindex

figure
imshow(uint8(Image_Fine_Filtered))
title("Fine WaveFiltering")

    