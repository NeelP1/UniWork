function Aprime = Q2bAux(t,  A)
%Q2BAUX Summary of this function goes here
%   Detailed explanation goes here
deathRate = 0.10;
rateOfInfection = 0.0005; %low assuming susceptables will avoid infectants
birthRate = 0.15;

Aprime = [birthRate * A(1) - rateOfInfection * A(1)*A(2);
    -deathRate * A(2) + rateOfInfection * A(1)*A(2)];

end

