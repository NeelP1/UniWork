
function lab6Q1()

%change in time
deltaT = 0.25;

%half life (5 hours)  *******variable********
thalf = 20;

%volume of distribution
Vd = 70;
%absorption rate constant and elimination rate constant
Ka = 1;
Ke = 0.639/thalf;

%initial values
I = 0;
P = 0;
U = 0;

%multiplier
m = 4;

%T = t
T = 0:192 * m;

%dosage *********variables**************
d = 70; %eg. 10 = 10 mg
dintv = 30; %4 = 1 hour


%question 3 *******variables************
min = 4;
max = 8;


%192 hours
for t = 1:192 * m
    %dosage interval and dosage amount
    if mod(t,dintv) == 0
        I(t+1) = I(t) - I(t)*Ka*deltaT + d;
        %disp('I reached here');
    else
        I(t+1) = I(t) - I(t)*Ka*deltaT;
    end
    P(t+1) = P(t) + I(t)*Ka*deltaT - P(t)*Ke*deltaT;
    U(t+1) = U(t) + P(t)*Ke*deltaT; 
end

% to obtain concentration in mg
P = P/Vd;
plot(T, P);
title('Plasma Concentration Levels');
xlabel('Days (1 = 6 hours)');
ylabel('C_p');
%hold on


end