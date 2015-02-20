function lab3Q4()

%actual attempt
A = [0.1,0.2,0.3;0.4,0.5,0.6;0.7,0.8,0.9]
B = [0.1;0.3;0.5]

syms a b c
S = solve(0.1*a+0.2*b+0.3*c==0.1,0.4*a+0.5*b+0.6*c==0.3,0.7*a+0.8*b+0.9*c==0.5)
S = [S.a S.b S.c]

X = A\B

DetA = det(A)

end