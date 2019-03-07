close all
clear
clc;

A = 5;
T = 0;
sigma2_vals = [2500:-50:500, 500:-10:100, 100:-5:10, 10:-1:1];
snr = PCM_SNR(A,sigma2_vals);
pe = prob_err(A,T,sigma2_vals);

subplot(2,1,1)
plot(pe,snr);
hold on;
scatter(pe,snr);
xlabel('P_e');
ylabel('S/N');
title('S/N vs P_e');

subplot(2,1,2);
loglog(pe,snr);
hold on;
scatter(pe,snr);
xlabel('P_e');
ylabel('S/N');
title('logarithmic S/N vs P_e');