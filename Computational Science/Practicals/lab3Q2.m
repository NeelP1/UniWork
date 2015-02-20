
function lab3Q2(A)

if (rows(A) != columns(A) )
    error('matrix must be square.')
end

%switch rows using permutation matrix
%A = [1,2,3;4,5,6;7,8,9]
P = eye(size(A))

swap1 = input('swap row: ')
swap2 = input('with row: ')

%swap rows in perm matrix
P(swap1,swap1) = 0
P(swap1,swap2) = 1
P(swap2,swap2) = 0
P(swap2,swap1) = 1

S = P*A
end



