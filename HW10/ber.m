
SNR = 15;

%OOK
EbNo = 10^((SNR- 20*log10(0.8))/20);
disp('OOK');
disp(num2str(qfunc(sqrt(EbNo))));

%BPSK
disp('BPSK');
disp(num2str(qfunc(sqrt(2*EbNo))));


%QPSK
EbNo = 10^((SNR - 20*log10(1.6))/20);
disp('QPSK');
disp(num2str(qfunc(sqrt(2*EbNo))));

%8PSK
M = 8;
EbNo = 10^((SNR - 20*log10(2.4))/20);
disp('8PSK');
P_se = qfunc(sqrt(2*EbNo*log2(M)*(sin(pi/M)^2)));
disp(num2str(P_se*(M/2)/(M-1)));

%MQAM
M = 16;
EbNo = 10^((SNR - 20*log10(3.2))/20);
WER=4*qfunc(sqrt(2*EbNo*(10^(-4/20))));
disp('16QAM');
disp(num2str(WER*(M/2)/(M-1)));

M=64;
EbNo = 10^((SNR - 20*log10(4.8))/20);
WER=4*qfunc(sqrt(2*EbNo*(10^(-8.5/20))));
disp('64QAM');
disp(num2str(WER*(M/2)/(M-1)));

M=256;
EbNo = 10^((SNR - 20*log10(5.6))/20);
WER=4*qfunc(sqrt(2*EbNo*(10^(-13.3/20))));
disp('256QAM');
disp(num2str(WER*(M/2)/(M-1)));




