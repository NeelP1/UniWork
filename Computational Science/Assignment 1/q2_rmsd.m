%Neel Patel
%24176540

function rmsd =  q2_rmsd(U,V)

%find centroid of U,V

[rowsu colsu] = size(U);
[rowsv colsv] = size(V);

sumu = sum(U);
sumv = sum(V);

gcu = [sumu(1)/rowsu , sumu(2)/rowsu, sumu(3)/rowsu];
gcv = [sumv(1)/rowsv , sumv(2)/rowsv, sumv(3)/rowsv];
%centroids of U,V above

%move geometric centres (centroid) to the origin
Uprime = [];
Vprime = [];
for i = 1:rowsu
    Uprime = [Uprime; U(i,1)-gcu(1), U(i,2)-gcu(2), U(i,3)-gcu(3)];
    Vprime = [Vprime; V(i,1)-gcv(1), V(i,2)-gcv(2), V(i,3)-gcv(3)];
end

%RMSD computation

M = zeros(4,4);
%4x4 symetric matrix
for i = 1:rowsu
    mx = Vprime(i,1)-Uprime(i,1);
    my = Vprime(i,2)-Uprime(i,2);
    mz = Vprime(i,3)-Uprime(i,3);
    
    px = Vprime(i,1)+Uprime(i,1);
    py = Vprime(i,2)+Uprime(i,2);
    pz = Vprime(i,3)+Uprime(i,3);
    
    M(1,1) = mx^2 + my^2 + mz^2 + M(1,1);
    M(1,2) = py*mz - my*pz + M(1,2);
    M(1,3) = mx*pz - px*mz + M(1,3);
    M(1,4) = px*my - mx*py + M(1,4);

    M(2,2) = py^2 + pz^2 + mx^2 + M(2,2);
    M(2,3) = mx*my - px*py + M(2,3);
    M(2,4) = mx*mz - px*pz + M(2,4);
    
    M(3,3) = px^2 + pz^2 + my^2 + M(3,3);
    M(3,4) = my*mz - py*pz + M(3,4);
    
    M(4,4) = px^2 + py^2 + mz^2 + M(4,4);
end
%because of the symetric nature of the matrix some computation time can be
%saved
M(2,1) = M(1,2);
M(3,1) = M(1,3);
M(3,2) = M(2,3);
M(4,1) = M(1,4);
M(4,2) = M(2,4);
M(4,3) = M(3,4);

%compute rmsd using eigan values of above 4x4 matrix
eiganV = eig(M);
minEigan = min(eiganV);
meanE = minEigan/rowsu;
rmsd = sqrt(meanE);

end