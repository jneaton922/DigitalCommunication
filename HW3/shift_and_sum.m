
N = 20;
bit_values = [-1 1];
Tb = 0.2;
spb = 16;
[t, pulse] = rp(Tb,spb);
[t, sinc_pulse] = sp(Tb,spb);

time = linspace(-5*Tb, (N+4.5)*Tb, (N+9.5)*spb);

while true
    B = bits(N, bit_values);
    st = zeros(1,length(time));
    sinc_st = zeros(1,length(time));
    % st = sum(0,(N-1)){ bit_n * pulse(t-nTb) }

    for i = 1:N
        shift = (i-1)*spb;
        st(1,shift+1:shift+10*spb) = st(1,shift+1:shift+10*spb) + B(i).*pulse(2:end);
        sinc_st(1,shift+1:shift+10*spb) = sinc_st(1,shift+1:shift+10*spb) + B(i).*sinc_pulse(2:end);
    end

    subplot(3,1,1);
    stem(B);
    subplot(3,1,2);
    plot(time,st);
    subplot(3,1,3);
    plot(time,sinc_st);
    pause();
end
