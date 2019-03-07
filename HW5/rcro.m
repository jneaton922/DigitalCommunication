function [t,ht] = rcro(k,Tb,spb,r)
    % Tb = 1/2f0
    % r = fd/f0
    % matlab sinc is sin(pix)/pix
    fo=1/(2*Tb);fd=fo*r;    
    t = -k*Tb:Tb/spb:k*Tb;
    ht = sinc(2*fo*t).*cos(2*pi*fd*t)./(1 - (4*fd*t).^2);
    dbz = abs(abs(t)-(1/(4*fd)))<((Tb/(10*spb)));
    ht(dbz) = (pi/4)*sinc(1/(4*Tb*fd));
end