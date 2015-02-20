%Neel Patel
%24176540

function re = q1a_script(x)

% log_e(1 + x)

a = 0;%approximation
d = 0;%difference in approximation from n and n-1
ae = 0;%absolute error
re = 0;%relative error
t = 0;%term t = n

f = log(1 + x);%actual value

for n = 1:1000000 %1 million terms
t = n;

d = a;
a = a + ((-1)^(n+1) * x^n)/n;

%difference in approximation
d = abs(d - a);
ae = a - f;
re = 100 * (ae/f);

    if n > 1 && d < 10^-6
        break
    end

end

fprintf('x: %f, approximation value: %g, actual value: %g, term: %f, abosulte error: %g, relative error: %g\n', x, a, f, t, ae, re);


end