clear;
close all;
clc;

%couch fig 5-31 b (p369)

% generate data
Ap = 1;
data_values = Ap*[0 1];
num_bits = 4*1e3;
k = 5; 
spb = 256;

r = 0.1;
B = 5e3;
R = B*2/(1+r);
Tb = 1/R;
fc = 1e4;
[~,pulse] = rt_rcro(k,Tb,spb,r);
Ac = (1);
levels = [-Ac/sqrt(2) -Ac/(3*sqrt(2)) Ac/(3*sqrt(2)) Ac/sqrt(2)]; 
thresholds = [(levels(1)+levels(2))/2,(levels(2)+levels(3))/2,(levels(3)+levels(4))/2];

nv = 0;
for nv = 0:0.1:10
        %generate data
    orig_data = bits(num_bits,data_values);
    data = hamming_7_4(orig_data,data_values);

    % implementing 16QAM as two parallel 4-level bit streams w/o/hamming
    [idata,qdata] = bits_to_levels(orig_data,levels,data_values);
    [~,xt] = signal(idata,pulse,k,Tb,spb);
    [t,yt] = signal(qdata,pulse,k,Tb,spb);
    qam_t = cos(2*pi*fc*t).*xt - sin(2*pi*fc*t).*yt;


    % implementing 16QAM as two parallel 4-level bit streams w/hamming
    [coded_idata,coded_qdata] = bits_to_levels(data,levels,data_values);
    [~,coded_xt] = signal(coded_idata,pulse,k,Tb,spb);
    [ct,coded_yt] = signal(coded_qdata,pulse,k,Tb,spb);
    coded_qam_t = cos(2*pi*fc*ct).*coded_xt - sin(2*pi*fc*ct).*coded_yt;

    %channel effects
    nt = noise(ct,nv);
    coded_st = coded_qam_t + nt;
    nt = noise(t,nv);
    st = qam_t+nt;

    % IQ receiver;
    coded_r_xt = 2*conv(coded_st.*cos(2*pi*fc*ct),pulse,'same')./spb;
    coded_r_yt = 2*conv(coded_st.*-1.*sin(2*pi*fc*ct),pulse,'same')./spb;
    r_xt = 2*conv(st.*cos(2*pi*fc*t),pulse,'same')./spb;
    r_yt = 2*conv(st.*-1.*sin(2*pi*fc*t),pulse,'same')./spb;

    coded_i_points = coded_r_xt((k*spb):spb:end-(k+1)*spb);
    coded_q_points = coded_r_yt((k*spb):spb:end-(k+1)*spb);
    i_points = r_xt((k*spb):spb:end-(k+1)*spb);
    q_points = r_yt((k*spb):spb:end-(k+1)*spb);

    coded_recovered_data = qam_sample(coded_r_xt,coded_r_yt,spb,k,thresholds,data_values);
    recovered_data = qam_sample(r_xt,r_yt,spb,k,thresholds,data_values);
    coded_recovered_bits = de_hamming_7_4(coded_recovered_data,data_values);
    ber = sum(recovered_data~=orig_data)/num_bits;
    coded_ber = sum(coded_recovered_bits~=orig_data)/num_bits;

    figure(1);
        title(strcat('NV: ',num2str(nv)));
    subplot(1,2,1);cla;
    scatter(i_points,q_points,'*');
    xlim([-Ac Ac]);ylim([-Ac Ac]);
    title(strcat('uncoded BER: ',num2str(ber))); 
    hold on;
    plot([thresholds(1),thresholds(1)],[-Ac,Ac],'r--');plot([-Ac Ac],[thresholds(1),thresholds(1)],'r--');
    plot([thresholds(2),thresholds(2)],[-Ac,Ac],'r--');plot([-Ac Ac],[thresholds(2),thresholds(2)],'r--');
    plot([thresholds(3),thresholds(3)],[-Ac,Ac],'r--');plot([-Ac Ac],[thresholds(3),thresholds(3)],'r--');
    subplot(1,2,2);cla;
    scatter(coded_i_points,coded_q_points,'*');
    xlim([-Ac Ac]);ylim([-Ac Ac]);
    title(strcat('Hamming BER: ',num2str(coded_ber))); 
    hold on;
    plot([thresholds(1),thresholds(1)],[-Ac,Ac],'r--');plot([-Ac Ac],[thresholds(1),thresholds(1)],'r--');
    plot([thresholds(2),thresholds(2)],[-Ac,Ac],'r--');plot([-Ac Ac],[thresholds(2),thresholds(2)],'r--');
    plot([thresholds(3),thresholds(3)],[-Ac,Ac],'r--');plot([-Ac Ac],[thresholds(3),thresholds(3)],'r--');
    
    pause();
end

