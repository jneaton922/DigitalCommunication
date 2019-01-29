n = linspace(-20,20,41);
w = 500*pi;
Cn = (exp(-1i.*n*3*pi/2) - 2*exp(-1i.*n*pi/2) + exp(1i.*n*pi/2));
Cn = Cn./(1i*2*pi*n);
stem(n,Cn);

x = ifft(Cn);