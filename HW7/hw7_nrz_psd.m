clear;
close all;
clc;

num_signals = 1000;
num_bits = 64;
values = [-5 5];
plot_delay=5e-3;
skip_plots = 5;
update_plot = true;
%update_plot = false;

R = 100;
Tb =1/R;
spb = 16;
k=1000;
N =spb*num_bits;
fs = spb/Tb;
freq = -fs/2:fs/N:fs/2 - fs/N;

%%% PULSE TYPE
[pt,pulse] = rp(k,Tb,spb);Ff = (sinc(freq*Tb));
%[pt,pulse] = sp(k,Tb,spb); Ff = (abs(freq) <= R/2);

%eq 3-41
A = values(1);
theor_psd = A^2 * Tb * (Ff).^2;
Psd=zeros(1,N);

%extra pulse periods from first and last tails (truncate to get to 512)
trunc_inds = (k)*spb;

%signal time in seconds
T = N*(Tb/spb);

for i=1:num_signals
    data = bits(num_bits,values);
    [t,bb] = baseband_signal(data,pulse,k,Tb,spb);
    bb = bb(1+trunc_inds:length(bb)-trunc_inds);
    Sf = (Tb/spb)*fftshift(fft(bb));
    Psd = Psd + (abs(Sf).^2)./(T);
    if i == 1
        plot(freq,abs(Sf));
        title('|S(f)|');
        figure();
    end
    
    if mod(i-1,skip_plots) == 0 && update_plot
        plot(freq,Psd/i,freq,theor_psd);
        legend({'Simulated','Theoretical'});
        pause(plot_delay);
    end
end

legend({'Simulated','Theoretical'});
title('PSD of Polar NRZ signaling');
xlabel('f (Hz)');
ylabel('P_s(f)');
figure();
plot(freq(freq>400),Psd(freq>400)/num_signals,freq(freq>400),theor_psd(freq>400));
legend({'Simulated','Theoretical'});
title('PSD of Polar NRZ signaling');
xlabel('f (Hz)');
ylabel('P_s(f)');

t = t(1+trunc_inds:length(t)-trunc_inds);



