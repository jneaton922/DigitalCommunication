close
clear all
clc

k = 5;
tb = 0.2;
spb = 16;
for r = 0.1:0.1:1
   [t,p] = rcro(k,tb,spb,r);
   plot(t,p);
   hold on;
end

title('RCRO rolloff Factors');
xlabel('t');
ylabel('h_e(t)');
    
    
    

