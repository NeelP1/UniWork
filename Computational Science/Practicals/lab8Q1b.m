function lab8Q1b()

%DE of Q2
I = 5; %initial number of infected
S = 200; %initial susceptables

%time = 1:200;
%Values = [200,0,0];

[t,A] = ode45(@Q1bAux, [1, 50], [S, I]);
%time = [time; t];
%Values = [Values; A];
figure
plot(t, A(:,1), t, A(:,2));
legend('Susceptables','Infectants');

%phase plane

figure
plot(A(:,1), A(:,2));
xlabel('Susceptables');
ylabel('Infectants');

end
