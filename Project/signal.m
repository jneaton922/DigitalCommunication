function [time, st] = baseband_signal(data,pulse,k,Tb,spb)
    N = length(data);
    time = linspace(-k*Tb, (N+k)*Tb, (N+(2*k))*spb);
    st = zeros(1,length(time));
    for i = 1:N
        shift = (i-1)*spb;
        st(1,shift+1:shift+length(pulse)) = st(1,shift+1:shift+length(pulse)) + data(i).*pulse;
    end
end
