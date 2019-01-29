% square wave t = [0,8], 0.2 ms between samples

fs = 1/0.2;
T = 128;
t = linspace(0,T,T*fs);
x = square(((t+1)*pi/2));
a = max(abs(x-x(end:-1:1)));

n = length(x);
X = fftshift(fft(x)*(1/fs));
f = (-n/2:n/2-1)*(fs/n);


subplot(3,1,1);
plot(t,x);
ylim([-2 2]);
title('Part (a), x(t)');
xlabel('t');
ylabel('x(t)');

subplot(3,1,2);
plot(f,real(X));
title('Part (b), Real');
ylim([min(real(X))-1 max(real(X))+1]);
xlabel('f');
ylabel('Re{X(f)}');

subplot(3,1,3);
plot(f,imag(X));
ylim([min(imag(X))-1 max(imag(X))+1]);
title('Part (b), Imaginary');
xlabel('f');
ylabel('Im{X(f)}');

pause();
N = length(x);
n = 0:N-1;
x = 0.5*(x + x(mod(-n,N)+1));

X = fftshift(fft(x)*(1/fs));

subplot(3,1,1);
plot(t,x);
ylim([-2 2]);
title('Part (a), x(t)');
xlabel('t');
ylabel('x(t)');

subplot(3,1,2);
plot(f,real(X));
title('Part (b), Real');
ylim([min(real(X))-1 max(real(X))+1]);
xlabel('f');
ylabel('Re{X(f)}');

subplot(3,1,3);
plot(f,imag(X));
ylim([min(imag(X))-1 max(imag(X))+1]);
title('Part (b), Imaginary');
xlabel('f');
ylabel('Im{X(f)}');
