function bisecMethod(fun, v, l, u)

mid = 0;
tol = 10^-5;


while(abs(u-l) > tol)
    %get interval close to tolerance
    
    %mid value evaluated here
    mid = (u+l)/2;
    fprintf('mid: %f\n', mid);
    Fmid = subs(fun, v, mid);
    Flow = subs(fun, v, l);
    
    %call sign function on functions with l or mid as x
    if(sign(Fmid) == sign(Flow))
        l = mid;
    else
        u = mid;
    end
end    

fprintf('Root approximation bisection method: %f\n',mid)

end