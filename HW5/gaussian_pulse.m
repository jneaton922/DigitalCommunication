function [t,gp] = gaussian_pulse(k,Tb,spb)
    t = -k*Tb:Tb/spb:k*Tb;
    gp = exp((-t.^2)./Tb.^2);
end