function [ time, pulse ] = sp(k,Tb, sb)
    time = -k*Tb:(Tb/sb):k*Tb;
    pulse = sinc(time/Tb);
end