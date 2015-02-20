function q1(n)

%Generate a chess board with a candidate solution, 1 represents a queen
%occupying that box
chessBoard = zeros(n,n);

for i = 1:n
    randRow = randi(n);
    chessBoard(randRow, i) = 1;
end
[conflicts, queenMatrix] = queensInConflict(chessBoard);
[chessBoard, queenMatrix] = perturb(chessBoard, queenMatrix);

c = 100;
while (c >= 0)
    
    for i =1:1000
        
        curr_cost = queensInConflict(chessBoard);
       
        updated_chessBoard = perturb(chessBoard, queenMatrix);
        
        [updated_curr_cost, updated_queenMatrix] = queensInConflict(updated_chessBoard);
        
        delta = updated_curr_cost - curr_cost;
        
        if(delta < 0)
            chessBoard = updated_chessBoard;
            queenMatrix = updated_queenMatrix;
            curr_cost = updated_curr_cost;
        else
            
            r = rand;
            p = exp(-delta/c);
            
            if( r <= p )
                chessBoard = updated_chessBoard;
                queenMatrix = updated_queenMatrix;
                curr_cost = updated_curr_cost;
            end
            
        end
        
    end
    if(curr_cost == 0)
        break;
    end
    
    c = c*0.85;
end
chessBoard
curr_cost

end


function [chessBoard, queenMat] = perturb(chessBoard, queenMat)

rows = size(queenMat,1);
rand = randi([2,rows], 1);

n = size(chessBoard,1);
queenRow = queenMat(rand, 1);
queenRowNew = mod(queenRow,n)+1;
queenMat(rand, 1) = queenRowNew;

chessBoard(queenRow, queenMat(rand, 2)) = 0;
chessBoard(queenRowNew, queenMat(rand, 2)) = 1;

end

function [conflictPairs, diagonalMatrix] = queensInConflict(chessBoard)

    conflictPairs = 0;
    sizeN = size(chessBoard,1);
    diagonalMatrix = [0, 0];
    for i = 1:sizeN

        for j = 1:sizeN

            if(chessBoard(i,j) == 1)
                for k = (i+1):sizeN
                    if(chessBoard(k,j) == 1)
                        conflictPairs = conflictPairs+1;
                    end
                end

                for k = (j+1):sizeN
                    if(chessBoard(i,k) == 1)
                        conflictPairs = conflictPairs+1;
                    end
                end
                diagonalMatrix = [diagonalMatrix; i, j];
            end
        end
    end

    rows = size(diagonalMatrix,1);

    for i = 2:rows

        for j = (i+1):rows

            deltaRow = abs(diagonalMatrix(i,1) - diagonalMatrix(j,1));
            deltaCol = abs(diagonalMatrix(i,2) - diagonalMatrix(j,2));
            if(deltaRow == deltaCol)
                conflictPairs = conflictPairs+1;
            end
        end

    end

end