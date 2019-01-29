function [ time, pulse ] = sp(Tb, sb)
    time = -5*Tb:(Tb/sb):5*Tb;
    pulse = sinc(time/Tb);
end