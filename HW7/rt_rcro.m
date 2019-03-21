function [t,ht] = rt_rcro(k,Tb,spb,r)
    % Tb = 1/2f0
    % r = fd/f0
    R = 1/Tb;
    t = -k*Tb:Tb/spb:k*Tb;
    
    
    ht = (sin(pi*R*t*(1-r)) + 4*R*r*t.*cos(pi*R*t*(1+r)));
    ht = ht./(pi*R*t.*(1 - (4*R*r*t).^2));
    
    ht(t==0) = 1 - r + (4*r/pi);
    dbz = abs(abs(t)-(Tb/4/r)) < (Tb/(10*spb));
    ht(dbz) = (r/sqrt(2)) * ( (1+(2/pi))*sin(pi/4/r) + (1-(2/pi))*cos(pi/4/r));
    
end