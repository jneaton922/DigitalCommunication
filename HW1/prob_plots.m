clear all;
close all;
clc;

p = linspace(0,0.01,100);
P0 = 1 - (1-p).^9;
Pd = 9*p.*(1-p).^8 + 84*(p.^3).*(1-p).^6 + 126*(p.^5).*(1-p).^4 + 36*(p.^7).*(1-p).^2 + p.^9;
Pu = 1 - Pd - (1-p).^9;
PH = 1 - ((1-p).^14 + 14.*p.*(1-p).^13);


titles = { 'P0' 'Pd' 'Pu' 'PH'};
plots = zeros(1,4);

plots(1,1) = plot(p,P0);hold on;
plots(1,2) = plot(p,Pd);hold on;
plots(1,3) = plot(p,Pu);hold on;
plots(1,4) = plot(p,PH);hold on;
legend(plots(1,:),titles(:));




