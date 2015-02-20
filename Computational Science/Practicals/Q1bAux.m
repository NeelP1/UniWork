function Aprime = Q1bAux(t,  A)
%Q2BAUX Summary of this function goes here
%   Detailed explanation goes here
deathRate = 0.2;
rateOfInfection = 0.005; %low assuming susceptables will avoid infectants
%birthRate = 0.15;

Aprime = [-rateOfInfection * A(1)*A(2);
    -deathRate * A(2) + rateOfInfection * A(1)*A(2)];

end
