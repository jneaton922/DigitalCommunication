clear
close all 
clc

num_bits = 100;
bit_values = [-1 1];
    
b = bits(num_bits, bit_values);
stem(b);
ylim([-1.5 1.5]);
xlabel('n');
ylabel('a_n');

ones = sum(b==1);
disp(ones);




