clc,clear,close all
myu = 0;
alpha = 1;
beta = 1;
syms x

P = beta/(2*alpha*gamma(1/beta))*exp(-(abs(x-myu)/alpha).^beta);
fplot(x,P)