clear;
close all
clc;

% part a
figure();
k=5;Tb=1e-3;spb=16;
min_r = 0.1;
max_r = 1;

for r=min_r:0.1:max_r
    [t,ht] = rt_rcro(k,Tb,spb,r);
    hold on;
    plot(t,ht);
end
legend({'0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0'});
title('Root-RCRO Pulse');
xlabel('t');ylabel('h(t)');
pause();

% part b
num_bits = 20;
R = 28.8e3;
Tb = 1/R;
spb = 16;
r = 0.4;
[~,pulse] = rt_rcro(k,Tb,spb,r);

data = bits(num_bits,[-1 1]);
[t, bb_signal] = baseband_signal(data,pulse,k,Tb,spb);
figure();
plot(t,bb_signal);
hold on;
title('Baseband RRCRO Signal (r = 0.4)');
xlabel('t');ylabel('s(t)');
pause();

% part c
filtered_bb = conv(bb_signal, pulse,'same')./spb;
figure();
plot(t,filtered_bb);
xlabel('t');ylabel('s(t)');
title('RRCRO Filtered Baseband');
hold on;
scatter((0:(num_bits-1)).*Tb, data,'r*');
pause();

figure();
variance = 10;
nt = noise(t,variance);
noisy_signal = bb_signal+nt;
subplot(3,1,1);
plot(t,bb_signal);
title('Original Baseband Signal');
hold on;
scatter((0:(num_bits-1)).*Tb, data,'r*');
xlabel('t');ylabel('s(t)');

subplot(3,1,2);
plot(t,noisy_signal);
title('Baseband With Noise');
xlabel('t');ylabel('r(t)=s(t)+n(t)');

filtered_bb = conv(noisy_signal,pulse,'same')./spb;
subplot(3,1,3);
plot(t,filtered_bb);
hold on;
scatter((0:(num_bits-1)).*Tb, data,'bo');
xlabel('t');
ylabel('r_o(t)');

% threshold halfway between values
gamma = 0;
recovered_data = sample_signal(filtered_bb,gamma,num_bits,spb,k);
ber = sum(data~=recovered_data)/num_bits;
scatter((0:(num_bits-1)).*Tb, recovered_data,'rx');
legend({'signal', 'original bit', 'recovered bit'});
title(strcat('Filtered Noisy Signal BER: ',num2str(ber)));



