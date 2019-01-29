clear
close all
clc

x1 = 0;
max_x = 1e10;
x2 = 0;

f_min = 1000;
f_max = 5e4;
f_inc = 1000;
B = [];

for f = linspace(f_min,f_max,((f_max-1)/f_inc)-1)
    target_power = f*pi*0.99/(2*sqrt(2));
    total = 0;

    disp(f);
    while x2 <= max_x && total < target_power 
        N = x2/2; 
        total = 0;
        dx = (x2-x1)/N;

        for n = 1:N-1
            x = x1+(n*dx);
            total = total + (1/(1+ (x/f)^4))*dx;
        end

        x2 = x2+1;
        %disp(total);    
    end
    B = [B, x2];
    % disp(x2);
end

scatter(linspace(f_min,f_max,((f_max-f_min)/f_inc)-1),B);
ylabel('B*f0');
xlabel('f0');
grid('on');
title('99% Energy BW');

