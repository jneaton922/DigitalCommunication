function [xmod] = bpsk(x,t,fc,Ac)
    % as ASK just multiply by cos
    xmod = x*Ac.*cos(2*pi*fc*t);
end