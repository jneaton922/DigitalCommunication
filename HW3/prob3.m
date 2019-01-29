clear
close all
clc

A = 1/(2*pi);

[X, Y] = meshgrid(-8:0.1:8);
Z = A*exp(-0.5*((X-2).^2 + Y.^2));

mesh(X,Y,Z);