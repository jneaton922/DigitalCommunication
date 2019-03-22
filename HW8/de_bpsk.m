function [xdemod] = de_bpsk(x,t,fc,Ac)
    xdemod = (2)*x.*cos(2*pi*fc*t);
end