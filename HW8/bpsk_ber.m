clear
close all
clc

eb_no = -25:0.01:20;
arg = sqrt(2*10.^(eb_no/20));
th_pe = qfunc(arg);

figure();
semilogy(eb_no,th_pe,'r--');
title('P_e and E_b/N_o');
xlabel('E_b/N_o');
ylabel('P_e');

fc = 1e5;
Ac = 1;
R = 28.8e3;
Tb = 1/R;
spb = 16;
k = 5;
r = 0.4;
num_bits = 1e2;
num_trials = 1000;
values = [-1 1];
[~,pulse] = rt_rcro(k,Tb,spb,r);
dv = 1;
max_nv = 100;

ber = zeros(1,max_nv/dv);
Eb_No = zeros(1,max_nv/dv);
Eb = sum(pulse.^2);

for i=1:num_trials
    disp(i);
    noise_variance = dv;
    ind = 1;
    data = bits(num_bits,values);
    [t, bb_signal] = baseband_signal(data,pulse,k,Tb,spb);
    modulated_signal = bpsk(bb_signal,t,fc,Ac);
    while noise_variance < max_nv
        nt = noise(t,noise_variance);
        noisy_signal = modulated_signal+nt;
        filtered_output = conv(de_bpsk(noisy_signal,t,fc,Ac),pulse,'same')./spb;
        gamma = mean(values);
        recovered_data = sample_signal(filtered_output,gamma,num_bits,spb,k,values);
        this_ber = sum(data~=recovered_data)/num_bits;
        ber(ind) = ber(ind)+this_ber;
        P_n = sum(nt.^2)/(length(nt)*Tb);
        B = R/2;
        No = P_n/B;
        Eb_No(ind) = Eb_No(ind) + Eb/No;
        noise_variance = noise_variance + dv;
        ind = ind+1;
    end
end
Eb_No = Eb_No./num_trials;
ber = ber./num_trials;

hold on;
x = 20*log10(Eb_No);
plot(x,ber);
legend({'Theoretical','Simulated'});