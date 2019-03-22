clear;
close all
clc;


num_bits = 10;
R = 1e3;
spb = 32;
fc = 1e5;
Ac = 1;
Ap = 1;

noise_variance = 10;

Tb = 1/R;
k=5;
r = 0.4;

[~,pulse] = rt_rcro(k,Tb,spb,r);
%[~,pulse] = rp(k,Tb,spb);
%[~,pulse] = sp(k,Tb,spb);

data_values = Ap*[-1 1];
data = bits(num_bits,data_values);
[t, bb_signal] = baseband_signal(data,pulse,k,Tb,spb);
figure();
plot(t,bb_signal);
hold on;
title('Baseband RRCRO Signal (r = 0.4)');
xlabel('t');ylabel('s(t)');
pause();

modulated_signal = bpsk(bb_signal, t, fc, Ac);
nt = noise(t,noise_variance);
modulated_noisy_signal = modulated_signal + nt;

figure();
plot(t,modulated_noisy_signal);
title('Modulated Signal (with Noise)');

%return to baseband
demodulated_signal = de_bpsk(modulated_noisy_signal,t,fc,Ac);

%matched filter
matched_filter = pulse;
filtered_output = conv(demodulated_signal,matched_filter,'same')./spb;

gamma = mean(data_values);
recovered_data = sample_signal(filtered_output,gamma,num_bits,spb,k,data_values);

figure();
plot(t,filtered_output);
hold on;
scatter((0:(num_bits-1)).*Tb,recovered_data,'r*');
title('Coherent RX Output');