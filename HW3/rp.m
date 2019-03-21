function [ time, pulse ] = rp(Tb, spb)
    time = -5*Tb:(Tb/(spb)):5*Tb;
    pulse = (abs(time) < Tb/2) - 0.5*(round(abs(time)*1000)==500*Tb);
end