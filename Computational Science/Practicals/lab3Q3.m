function lab3Q3()
A = [4,2,4;1,2,2;4,4,6]
b = [6;3;10]
%a)naive gaussian elimination
sizeA = size(A,1)
V = 0

for i=1:sizeA - 1
    if A(i,1) > A(i+1,1)
        %equa = A(i+1,1)/A(i,1)
        for j=1:sizeA
            V = A(i+1,j)-(A(i+1,1)/A(i,1))*A(i,j)
            Q = V
            %A(i+1,j) = Q
        end
    elseif A(i,1)==A(i+1,1)
        for j=1:sizeA
            A(i+1,j)=A(i+1,j)-A(i,j);
        end
    end
end

end

