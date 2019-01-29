function [ time, pulse ] = rp(Tb, spb)
    time = -5*Tb:(Tb/(spb)):5*Tb;
    pulse = (abs(time) < Tb/2) - 0.5*(round(abs(time)*100)==50*Tb);
end