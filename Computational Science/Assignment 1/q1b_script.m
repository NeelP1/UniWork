%Neel Patel
%24176540
function re = q1b_script(x)

% log_e(1 + y/1 - y)

a = 0;%approximation
f = 0;%actual function
d = 0;%difference in approximation from n and n-1
ae = 0;%absolute error
re = 0;%relative error
t = 0;%term t = n

%y in terms of x
y = x/(2+x);

%actual value
f = log((1 + y)/(1 - y));

for n = 1:1000000 %1 million terms
    t = n;
    %d is equal to last approximation
    d = a;
    a = a + 2*((y^(2*n-1))/(2*n-1));

    %last approximation - current approximation
    d = abs(d - a);
    ae = a - f;
    re = 100 * (ae/f);

    if n > 1 && d < 10^-6
        break
    end

end

fprintf('x: %f, approximation value: %g, term: %f, abosulte error: %g, relative error: %g\n', x, a, t, ae, re);

end