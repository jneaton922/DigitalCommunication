clear;
close all;
clc;

eb_no = -1:0.1:15;
arg_bpsk = sqrt(2*10.^(eb_no/20));
arg_ook = sqrt(10.^(eb_no/20));

ber_bpsk = qfunc(arg_bpsk);
ber_ook = qfunc(arg_ook);
ber_ml = (0.5*(1-ber_bpsk)) + 0.5*(qfunc(5*arg_bpsk)-ber_bpsk);

semilogy(eb_no,ber_bpsk,eb_no,ber_ook,eb_no,ber_ml);
legend({'bpsk','ook','4-level'});

eb_no = -40:0.1:0;
arg_bpsk = sqrt(2*10.^(eb_no/20));
arg_ook = sqrt(10.^(eb_no/20));

ber_bpsk = qfunc(arg_bpsk);
ber_ook = qfunc(arg_ook);
ber_ml = (0.5*(1-ber_bpsk)) + 0.5*(qfunc(5*arg_bpsk)-ber_bpsk);


figure();
semilogy(eb_no,ber_bpsk,eb_no,ber_ook,eb_no,ber_ml);
legend({'bpsk','ook','4-level'});

% figure();
% r=0.35;
% l = 2;
% R = 1;
% D = R/l;
% f0 = 1/2;
% B = (1+r)*D;
% 
% fd=B-f0;
% f1 = f0-fd;
% 
% freq = 0:0.001:5;
% He = zeros(1,length(freq));
% for i = 1:length(freq)
%    if  freq(i) < f1
%        He(i) = 1;
%    elseif freq(i)<B
%        He(i) = 0.5*(1+ cos(pi*(freq(i)-f1)/(2*fd)));
%    end
% end
% 
% plot(freq./R,10*log10(He));


