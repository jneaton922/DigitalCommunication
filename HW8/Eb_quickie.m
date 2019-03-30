k=5;
Tb=1e-3;
spb=1024;
r=0.5;
fc=10000;
[t,pulse] = rt_rcro(k,Tb,spb,r);
Eb =[];
for Ac=1:0.1:100
    bit=pulse.*Ac.*cos(2*pi*fc.*t);
    Eb = [Eb, sum(bit.^2)];
end

plot(1:0.1:100,Eb,1:0.1:100,(spb/2)*(1:0.1:100).^2);
Ac = 10;
R = 20e6;
B = 15e5;
ookeb = Ac^2 / 4;
bpskeb = Ac^2 / 2;
offset = 10*log(R/B)
for Pe = [1e-5 1e-6 1e-7]
    arg = qfuncinv(Pe);
    
    ook_ebno = arg^2;
    ook_no = 10*log10(ookeb/(10^(ook_ebno/10)));
    ook_snr = 
    
    bpsk_ebno = ook_ebno/2;
    bpsk_no = 10*log10(bpskeb/(10^(bpsk_ebno/10)));
    bpsk_no = bpskeb
end


