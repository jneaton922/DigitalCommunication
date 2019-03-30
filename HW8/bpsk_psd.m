clear;
close all
clc;

% Simulation Parameters
num_bits = 128;
R = 1e3;
spb = 256;
fc = 1e5;
Ac = 1;
Ap = 1;
values = Ap*[-1 1];
num_signals = 5000;
plot_delay=1e-3;
skip_plots = 50;
update_plot = true;

Tb = 1/R;
k=5;
r = 0.4;
[~,pulse] = rt_rcro(k,Tb,spb,r);

N =spb*num_bits;
fs = spb/Tb;
bin_res = fs/N;
freq = -fs/2:fs/N:fs/2 - fs/N;

A = values(1);
Ff = fftshift(fft(pulse,N));
theor_psd = Ac^2 * Tb/4 * (abs(Ff)/spb).^2;
theor_psd = circshift(theor_psd,floor(fc/bin_res)) + circshift(theor_psd,ceil(-fc/bin_res));
Psd=zeros(1,N);

trunc_inds = (k)*spb;
T = N*(Tb/spb);


for i=1:num_signals
    data = bits(num_bits,values);
    [t,bb] = baseband_signal(data,pulse,k,Tb,spb);
    bb = bb(1+trunc_inds:length(bb)-trunc_inds);
    t = t(1+trunc_inds:length(t)-trunc_inds);
    
    mod_signal = bpsk(bb,t,fc,Ac);
    Sf = ((Tb)/spb)*fftshift(fft(mod_signal));
    Psd = Psd + (abs(Sf).^2)./(T);    
    if mod(i-1,skip_plots) == 0 && update_plot
        plot(freq,Psd/i,freq,theor_psd);
        legend({'Simulated','Theoretical'});
        pause(plot_delay);
    end
end

legend({'Simulated','Theoretical'});
title('PSD of BPSK signaling');
xlabel('f (Hz)');
ylabel('P_s(f)');

t = t(1+trunc_inds:length(t)-trunc_inds);
