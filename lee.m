%% 第二步：对两幅图像进行相干波滤波（Lee滤波）  
%Lee滤波

close all;
clear;
clc;
% cd SARImageFile\SARImageData\
IMAGE=imread('yellow_C_1.bmp');
figure();
imshow(IMAGE);title('原图');
[l,w]=size(IMAGE);
WL=7;%Lee滤波的窗长
IMAGE_filtered=zeros(l-floor(WL/2),w-floor(WL/2));
for i=floor(WL/2)+1 : l-floor(WL/2) %WL*WL滤波
    for j=floor(WL/2)+1 : w-floor(WL/2)
        Window=IMAGE(i-floor(WL/2) : i+floor(WL/2),j-floor(WL/2) : j+floor(WL/2));
        %取窗口的数据
        [k,p]=size(Window);
        Temp=reshape(Window,1,k*p);
        Average=mean(Temp);
        SD2=std2(Temp)*std2(Temp);
        var_x=(SD2-Average*Average)/2;
        a=1-var_x/SD2;
        b=var_x/SD2;
        IMAGE_filtered(i-floor(WL/2)+1,j-floor(WL/2)+1)=Average+b*(IMAGE(i,j)-Average);
    end
end
IMAGE_filtered=IMAGE_filtered/max(max(IMAGE_filtered));
IMAGE_filtered=imadjust(IMAGE_filtered,stretchlim(IMAGE_filtered),[],1);
figure();
imshow(IMAGE_filtered);title('Lee滤波图');



%% Lee精致滤波

tic

clc,clear,close all

IMAGE=imread('yellow_C_1.bmp');
[l,w]=size(IMAGE);
WL=7;%精致Lee一般采用7*7的窗口
M=zeros(3,3);
IMAGE_filtered_RL=zeros(l-floor(WL/2),w-floor(WL/2));
G1=[-1 0 1;-1 0 1;-1 0 1];%垂直模板
G2=[0 1 1;-1 0 1;-1 -1 0];%135度模板
G3=[1 1 1;0,0,0;-1 -1 -1];%水平模板
G4=[1 1 0;1 0 -1;0 -1 -1];%45度模板
GV=zeros(1,4);
for i=floor(WL/2)+1 : l-floor(WL/2) %WL*WL滤波
    for j=floor(WL/2)+1 : w-floor(WL/2)
       Window=IMAGE(i-floor(WL/2):i+floor(WL/2),j-floor(WL/2):j+floor(WL/2));
       %去窗口中的数据
       M(1,1)=mean(mean(Window(1:3,1:3)));
       M(1,2)=mean(mean(Window(1:3,3:5)));
       M(1,3)=mean(mean(Window(1:3,5:7)));
       M(2,1)=mean(mean(Window(3:5,1:3)));
       M(2,2)=mean(mean(Window(3:5,3:5)));
       M(2,3)=mean(mean(Window(3:5,5:7)));
       M(3,1)=mean(mean(Window(5:7,1:3)));
       M(3,2)=mean(mean(Window(5:7,3:5)));
       M(3,3)=mean(mean(Window(5:7,5:7)));
       GV(1,1)=sum(sum(G1.*M));
       GV(1,2)=sum(sum(G2.*M));
       GV(1,3)=sum(sum(G3.*M));
       GV(1,4)=sum(sum(G4.*M));
       [GV,GC]=max(GV);
       switch GC
           case 1%垂直模板
               WindowPart=Window(1:7,4:7);
               if abs(M(2,1)-M(2,2)) < abs(M(2,3)-M(2,2))
                   WindowPart=Window(1:7,1:4);
               end
           case 2%135度模板
               WindowPart=[Window(1:1,1);Window(1:2,2);Window(1:3,3);Window(1:4,4);Window(1:5,5);Window(1:6,6);Window(1:7,7)];
               if abs(M(3,1)-M(2,2)) < abs(M(1,3)-M(2,2))
                   WindowPart=[Window(1:7,1);Window(2:7,2);Window(3:7,3);Window(4:7,4);Window(5:7,5);Window(6:7,6);Window(7:7,7)];
               end
           case 3%水平模板
               WindowPart=Window(1:4,1:7);
               if abs(M(1,2)-M(2,2)) < abs(M(3,2)-M(2,2))
                   WindowPart=Window(4:7,1:7);
               end
           otherwise%45度模板
               WindowPart=[Window(7:7,1);Window(6:7,2);Window(5:7,3);Window(4:7,4);Window(3:7,5);Window(2:7,6);Window(1:7,7)];
               if abs(M(1,1)-M(2,2)) < abs(M(3,3)-M(2,2))
                   WindowPart=[Window(1:7,1);Window(1:6,2);Window(1:5,3);Window(1:4,4);Window(1:3,5);Window(1:2,6);Window(1:1,7)];
               end
       end
       [k,p]=size(WindowPart);
       Temp=reshape(WindowPart,1,k*p);
       Average=mean(Temp);
       SD2=std2(Temp)*std2(Temp);
       var_x=(SD2-Average*Average)/2;
       a=1-var_x/SD2;
       b=var_x/SD2;
       IMAGE_filtered_RL(i-floor(WL/2)+1,j-floor(WL/2)+1)=Average+b*(IMAGE(i,j)-Average);%精致Lee滤波后的图像
    end
end
IMAGE_filtered_RL=IMAGE_filtered_RL/max(max(IMAGE_filtered_RL));
IMAGE_filtered=imadjust(IMAGE_filtered_RL,stretchlim(IMAGE_filtered_RL),[],1);
figure();
imshow(IMAGE_filtered_RL);title('精致滤波后的图像');
%结果评价
u_o=mean(mean(IMAGE));%原始图像均值
var_o=std2(IMAGE)*std2(IMAGE);%原始图像方差
u_L=mean(mean(IMAGE_filtered));%Lee滤波后图像均值
var_L=std2(IMAGE_filtered)*std2(IMAGE_filtered);%Lee滤波后图像方差
u_RL=mean(mean(IMAGE_filtered_RL));%精致滤波后图像均值
var_RL=std2(IMAGE_filtered_RL)*std2(IMAGE_filtered_RL);%滤波后图像方差
ENL_o=u_o^2/var_o;%原始图像等效视数
ENL_L=u_L^2/var_L;%Lee滤波后图像等效视数
ENL_RL=u_RL^2/var_RL;%精致滤波后图像的等效视数
sum_L=0;
sum_o=0;
sum_RL=0;
for i=1:l-WL
    for j=1:w-WL
        sum_L=sum_L+abs(abs(IMAGE_filtered(i,j)-IMAGE_filtered(i+1,j))+abs(IMAGE_filtered(i,j)-IMAGE_filtered(i,j+1)));
        sum_RL=sum_RL+abs(abs(IMAGE_filtered_RL(i,j)-IMAGE_filtered_RL(i+1,j))+abs(IMAGE_filtered_RL(i,j)-IMAGE_filtered_RL(i,j+1)));
        sum_o=sum_o+abs(abs(IMAGE(i+floor(WL/2),j+floor(WL/2))-IMAGE(i+floor(WL/2)+1,j+floor(WL/2)))+abs(IMAGE(i+floor(WL/2),j+floor(WL/2))-IMAGE(i+floor(WL/2),j+floor(WL/2)+1)));
    end
end
ESI_L=sum_L/sum_o;%Lee滤波后图像的边缘保持指数
ESI_RL=sum_RL/sum_o;%精致Lee滤波后图像的边缘保持指数

toc