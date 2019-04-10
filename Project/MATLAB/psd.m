clear;
close all;
clc;

% psd should be ~ 5Ac^2 / 9 * Ts * H_e
% generate data
Ap = 1;
data_values = Ap*[0 1];
num_bits = 4*1e3;
k=5; 
sps=256;

r = 0.2;
B = 5e3;
R = B*2/(1+r);
Ts = 1/R;
fc = 1e4;
[~,pulse] = rt_rcro(k,Ts,sps,r);

Ac = 4;
levels = [-Ac/sqrt(2) -Ac/(3*sqrt(2)) Ac/(3*sqrt(2)) Ac/sqrt(2)]; 

num_signals =1e3;
N = (2*k + num_bits/4)*sps;
psd_s = zeros(1,N);
avg_Sf = zeros(1,N);
T = N*(Ts/sps);
fs = sps/(Ts);
freq = -fs/2:fs/N:fs/2-fs/N;

for i=1:num_signals    
    %generate data
    orig_data = bits(num_bits,data_values);
    % implementing 16QAM as two parallel 4-level bit streams w/o/hamming
    [idata,qdata] = bits_to_levels(orig_data,levels,data_values);
    [~,xt] = signal(idata,pulse,k,Ts,sps);
    [t,yt] = signal(qdata,pulse,k,Ts,sps);
    qam_t = cos(2*pi*fc*t).*xt - sin(2*pi*fc*t).*yt;
    Sf = (Ts/sps)*fftshift(fft(qam_t,N));
    avg_Sf = avg_Sf + Sf;
    psd_s = psd_s + (abs(Sf).^2)./T;
    subplot(2,1,1);
    cla;
    plot(freq,abs(psd_s)./i);xlim([0.1e4 1.9e4]);
    hold on;
    plot([.5e4 .5e4],[0 2.5e-5],'g--');
    plot([1.5e4 1.5e4],[0 2.5e-5],'g--');
    hold on;
    plot([.2e4 .2e4],[0 2.5e-5],'r--');
    plot([1.8e4 1.8e4],[0 2.5e-5],'r--');
    

    subplot(2,1,2);cla;
    plot(freq,20*log10(abs(psd_s)./i));xlim([0.1e4 1.9e4]);
    plot([.5e4 .5e4],[max(20*log10(abs(psd_s)./i))-20 100],'g--');
    plot([1.5e4 1.5e4],[max(20*log10(abs(psd_s)./i))-20 100],'g--');
    
    plot([0.2e4 0.5e4],[max(20*log10(abs(psd_s)./i))-20,max(20*log10(abs(psd_s)./i))-20],'g--');
    plot([1.5e4 1.8e4],[max(20*log10(abs(psd_s)./i))-20,max(20*log10(abs(psd_s)./i))-20],'g--');
    
    hold on;
    plot([.2e4 .2e4],[max(20*log10(abs(psd_s)./i))-55 100],'r--');
    plot([1.8e4 1.8e4],[max(20*log10(abs(psd_s)./i))-55 100],'r--');
    
    plot([0.1e4 0.2e4],[max(20*log10(abs(psd_s)./i))-55,max(20*log10(abs(psd_s)./i))-55],'r--');
    plot([1.8e4 1.9e4],[max(20*log10(abs(psd_s)./i))-55,max(20*log10(abs(psd_s)./i))-55],'r--');
    
    pause(1e-3);
end

psd_s = psd_s./num_signals;
offset = (fs/2+B)/(fs/N);
band_bins = round(B/(fs/N));
power_in_band = sum(psd_s(offset:offset+band_bins))*(fs/N)

