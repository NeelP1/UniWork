%use function for all equations
%tol = 10^-5

syms x;

bisecMethod(sym('x^3 - 2*x - 5'), x, -10, 10)

bisecMethod(sym('x'), x, -10, 10)

bisecMethod(sym('exp(1)^(-x)-x'), x, 0, 10)

bisecMethod(sym('x*sin(x) - 1'), x, 0, 5)

bisecMethod(sym('x^3 - 3*x^2 + 3*x - 1'), x, -10, 10)




