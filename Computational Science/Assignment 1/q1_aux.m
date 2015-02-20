%Neel Patel
%24176540

q1a_script(0.1)
q1a_script(0.5)
q1a_script(0.9)
q1a_script(0.999)
q1a_script(1.1)

q1b_script(0.1)
q1b_script(0.5)
q1b_script(0.9)
q1b_script(0.999)
q1b_script(1.1)

re = 0;
n = 1:100;
%q1a
for x = 1:100
   
    re(x) = q1a_script(x/100);
    
end

figure
plot(n/100,re)
xlabel('x')
ylabel('relative error')

%q1b
for x = 1:100
   
    re(x) = q1b_script(x/100);
    
end

figure
plot(n/100,re)
xlabel('x')
ylabel('relative error')