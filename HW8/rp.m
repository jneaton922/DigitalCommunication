function [ time, pulse ] = rp(k,Tb, spb)
    time = -k*Tb:(Tb/(spb)):k*Tb;
    pulse = double(abs(time) <= Tb/2) - 0.5*(abs(abs(time) - Tb/2) < (Tb/(10*spb)));
end