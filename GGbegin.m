clc,clear,close all
myu = 0;
alpha = 0;
beta = 0;
syms sita x

P = beta/(2*alpha*gamma(1/beta))*exp(-(abs(x-myu)/alpha).^beta);