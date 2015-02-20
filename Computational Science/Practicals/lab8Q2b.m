function lab8Q2b()

%DE of Q2
I = 20; %initial number of infected
S = 200; %initial susceptables


[t,A] = ode45(@Q2bAux, [1, 100], [S, I]);
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

