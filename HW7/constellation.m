clear;
close all;
clc;

A = 2;
T = 1/(1.54e6);
mag = sqrt(A^2 * T);
s1 = [mag 0 0];s2 = [0 mag 0];s3 = [0 0 mag];
scatter3(s1,s2,s3,'filled');
xlabel('r_1');
ylabel('r_2');
zlabel('r_3');
N = 32;

a = [zeros(1,N) linspace(0,mag,N) linspace(0,mag,N)];
b = [linspace(0,mag,N) zeros(1,N)  linspace(0,mag,N)];
c = [linspace(0,mag,N) linspace(0,mag,N) zeros(1,N) ];
hold on;
plot3(a,b,c,'--');

n = 0:N-1;
phi1 = ones(1,N);
phi2 = phi1 - 2*(n>N/2);
phi3 = phi1 -2*(n<N/4) -2*(n>(3*N/4));

y1 = phi1 + phi2 + phi3;%3
y2 = phi1 + phi2 - phi3;%
y3 = phi1 - phi2 + phi3;
y4 = phi1 - phi2 - phi3;
y5 = -1*phi1 + phi2 + phi3;
y6 = -1*phi1 + phi2 - phi3;
y7 = -1*phi1 - phi2 + phi3;
y8 = -1*phi1 - phi2 - phi3;

figure();
subplot(3,1,1);
plot(n,phi1);
subplot(3,1,2);
plot(n,phi2);
subplot(3,1,3);
plot(n,phi3);

figure();
subplot(4,2,1);plot(n,y1);
subplot(4,2,2);plot(n,y2);
subplot(4,2,3);plot(n,y3);
subplot(4,2,4);plot(n,y4);
subplot(4,2,5);plot(n,y5);
subplot(4,2,6);plot(n,y6);
subplot(4,2,7);plot(n,y7);
subplot(4,2,8);plot(n,y8);

figure();
x = mag*[1 1 1 1 -1 -1 -1 -1];
y = mag*[1 1 -1 -1 1 1 -1 -1];
z = mag*[1 -1 1 -1 1 -1 1 -1];
scatter3(x,y,z,'filled');
