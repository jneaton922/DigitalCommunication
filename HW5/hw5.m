clear;
close all;
clc;

N = 20;
bit_values = [-1 1];

k = 5;
Tb = 1;
spb = 16;
r = 0.5;
[t,pulse] = rcro(k,Tb,spb,r);
[t,gpulse] = gaussian_pulse(5,1,16);
time = linspace(-k*Tb,k+N*Tb,(2*k+N)*spb);



while true
    close all;
    B = bits(N, bit_values);
    rcro_st = zeros(1,length(time));
    gp_st = zeros(1,length(time));
    for i = 1:N
        shift = (i-1)*spb;
        rcro_st(1,shift+1:shift+10*spb) = rcro_st(1,shift+1:shift+10*spb) + B(i).*pulse(2:end);
        gp_st(1,shift+1:shift+10*spb) = gp_st(1,shift+1:shift+10*spb) + B(i).*gpulse(2:end);

    end

    subplot(3,1,1);
    stem(1:N,B);
    title('Binary Data');
    ylabel('a_n');
    xlabel('n');

    subplot(3,1,2);
    plot(time,rcro_st);
    bit_grid(time,N,Tb,bit_values);
    hold on;
    plot(0:Tb:(N-1)*Tb,B,'g*');
    title('RCRO pulse signaling');
    xlabel('t');
    ylabel('s(t)');

    subplot(3,1,3);
    plot(time,gp_st);
    bit_grid(time,N,Tb,bit_values);
    hold on;
    plot(0:Tb:(N-1)*Tb,B,'g*');
    title('Gaussian pulse signaling');
    xlabel('t');
    ylabel('s(t)');
    pause();
end




function bit_grid(t,N,Tb,vals)
    hold on;
    plot(t,vals(1)*ones(1,length(t)),'r');
    plot(t,(vals(1)/2)*ones(1,length(t)),'r--');
    hold on;
    plot(t,vals(2)*ones(1,length(t)),'r');
    plot(t,(vals(2)/2)*ones(1,length(t)),'r--');
    hold on;
    plot(t,zeros(1,length(t)),'color',[0 0 0]);

    for n = 0:N-1
        hold on;
        plot([n*Tb n*Tb],[vals(1) vals(2)],'color',[0.5 0.5 0.5]);
    end
end