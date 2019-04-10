clear;
close all;
clc;

% couch ch7 p524
% from couch : P(symbel error) <= 4*Q(rt(2(eb/no)*eta_m))
% eta_m for 16QAM = -4
eta_m = -4;M=16;K=4;
eb_no = -40:0.01:20;
arg = sqrt(2*(10.^(eb_no/20))*(10.^(eta_m/20)));
th_pe_lim = 4*qfunc(arg);
low_pe_lim = (1/K)*th_pe_lim;
high_pe_lim = (M/2)/(M-1) * th_pe_lim;

plot_time = 1e-3;
skip_plots = 5;
show_plots = true;

Ap = 1;
data_values = Ap*[0 1];
num_bits = 12*1e2;
k=5; 
spb=32;
max_nv = 100;
dv = 0.5;
num_trials = 500;

r = 0.6;
B = 5e3;
R = B*2/(1+r);
Tb = 1/R;
fc = 1e4;
[pt,pulse] = rt_rcro(k,Tb,spb,r);
Ac = 2;
levels = [-Ac/sqrt(2) -Ac/(3*sqrt(2)) Ac/(3*sqrt(2)) Ac/sqrt(2)]; 
thresholds = [(levels(1)+levels(2))/2,(levels(2)+levels(3))/2,(levels(3)+levels(4))/2];

% 4 with 2 levels(3)s
% 4 with 2 level(4)s
% 8 with 1 of each
avg = (levels(1) + levels(2))/2;
Es = sum((avg*pulse.*cos(2*pi*fc*pt) - avg*pulse.*sin(2*pi*fc*pt)).^2); 
Eb = Es/4;
%Eb = Es/4;
c_Eb = (7/4)*Eb;

ber = zeros(1,max_nv/dv);
c_ber = zeros(1,max_nv/dv);
Eb_No = zeros(1,max_nv/dv);
c_Eb_No = zeros(1,max_nv/dv);
avg_Eb = 0;

for i=1:num_trials
    noise_variance = dv;
    ind = 1;
    data = bits(num_bits,data_values);coded_data = hamming_7_4(data,data_values);
    
    [idata,qdata] = bits_to_levels(data,levels,data_values);
    [c_idata,c_qdata] = bits_to_levels(coded_data,levels,data_values);
    
    [~,xt] = signal(idata,pulse,k,Tb,spb);
    [t,yt] = signal(qdata,pulse,k,Tb,spb);
    [~,c_xt] = signal(c_idata,pulse,k,Tb,spb);
    [ct,c_yt] = signal(c_qdata,pulse,k,Tb,spb);
    
    qam_t = cos(2*pi*fc*t).*xt - sin(2*pi*fc*t).*yt;
    avg_Eb = avg_Eb + (sum(qam_t*(Tb/spb))^2  / num_bits);
        
    c_qam_t = cos(2*pi*fc*ct).*c_xt - sin(2*pi*fc*ct).*c_yt;
    while noise_variance < max_nv
        nt = noise(ct,noise_variance);
        st = qam_t+nt(1:length(t));
        c_st = c_qam_t + nt;
        
        r_xt = 2*conv(st.*cos(2*pi*fc*t),pulse,'same')./spb;
        r_yt = 2*conv(st.*-1.*sin(2*pi*fc*t),pulse,'same')./spb;
        c_r_xt = 2*conv(c_st.*cos(2*pi*fc*ct),pulse,'same')./spb;
        c_r_yt = 2*conv(c_st.*-1.*sin(2*pi*fc*ct),pulse,'same')./spb;
        
        recovered_data = qam_sample(r_xt,r_yt,spb,k,thresholds,data_values);
        coded_recovered_data = qam_sample(c_r_xt,c_r_yt,spb,k,thresholds,data_values);
        coded_recovered_bits = de_hamming_7_4(coded_recovered_data,data_values);
        
        this_ber = sum(data~=recovered_data)/num_bits;
        this_c_ber = sum(data~=coded_recovered_bits)/num_bits;
        ber(ind) = ber(ind)+this_ber;
        c_ber(ind) = c_ber(ind)+this_c_ber;
        
        P_n = sum(nt(1:length(t)).^2)/(length(t)*Tb);
        B = R/2;
        No = P_n/B;
        
        c_P_n = sum(nt.^2)/(length(nt)*Tb);
        B = R/2;
        c_No = P_n/B;
        
        Eb_No(ind) = Eb_No(ind) + Eb/No;
        c_Eb_No(ind) = c_Eb_No(ind) + c_Eb/c_No;
        noise_variance = noise_variance + dv;
        ind = ind+1;
    end
    if show_plots && mod(i,skip_plots)==0
        hold off;
        semilogy(eb_no,low_pe_lim,'r--'); hold on;
        semilogy(eb_no,high_pe_lim,'r--');
        x = 20*log10(Eb_No/i);
        cx = 20*log10(c_Eb_No/i);
        hold on;
        plot(x,ber/i,cx,c_ber/i);
        legend({'Couch Bounds','','Without Coding','With Hamming(7,4)'});
        title(strcat('P_e and E_b/N_0 -- Trial: ',num2str(i)));
        xlabel('E_b/N_o');
        ylabel('P_e');
        %legend({'Theoretical','Simulated'});
        pause(plot_time);
    end
end
Eb_No = Eb_No./num_trials;
ber = ber./num_trials;
%legend({'Theoretical','Simulated'});
