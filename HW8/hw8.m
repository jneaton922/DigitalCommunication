clear;
close all
clc;


num_bits = 40;
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
gamma = mean(data_values);

while true
    hold off;
    subplot(3,2,1);
    data = bits(num_bits,data_values);
    stem(1:num_bits,data);
    title('Bits');
    
    [t, bb_signal] = baseband_signal(data,pulse,k,Tb,spb);
    subplot(3,2,2);
    plot(t,bb_signal);
    title('Baseband Signal');
    
    modulated_signal = bpsk(bb_signal, t, fc, Ac);
    subplot(3,2,3);
    plot(t,modulated_signal);
    title('Modulated Signal');
    
    nt = noise(t,noise_variance);
    modulated_noisy_signal = modulated_signal + nt;
    subplot(3,2,4);
    plot(t,modulated_noisy_signal);
    title('Modulated Signal with Noise');

    demodulated_signal = de_bpsk(modulated_noisy_signal,t,fc,Ac);
    subplot(3,2,5);
    plot(t,demodulated_signal);
    title('Demodulated Signal');

    matched_filter = pulse;
    filtered_output = conv(demodulated_signal,matched_filter,'same')./spb;
    recovered_data = sample_signal(filtered_output,gamma,num_bits,spb,k,data_values);

    subplot(3,2,6);
    plot(t,filtered_output);
    hold on;
    scatter((0:(num_bits-1)).*Tb,recovered_data,'r*');
    hold on;
    scatter((0:(num_bits-1)).*Tb,data,'bo');
    title('Filter Output');
    legend({'r(t)','recovered bits','original bits'});

    pause();
end