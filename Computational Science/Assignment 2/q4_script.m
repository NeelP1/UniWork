function q4_script(seq1, seq2, submat, go, ge)

%Assignment 2 q4_script
%Neel Patel
%24176540


%parameters seq1,seq2,submat are filenames to be extracted in this script

seqOne = fileread(seq1);
seqTwo = fileread(seq2);
length1 = length(seqOne);
length2 = length(seqTwo);

%saturating gap penalty function
lambda = @(l) go + ge*(l-1);


fid = fopen(submat);
subMatInput = textscan(fid, '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s');
letterArray = subMatInput{1}';
%' transposes a matrix


subMatrix = zeros(20,20);

%empty memorisation matrices
editDistM = zeros(length1+1, length2+1);
editDistD = zeros(length1+1, length2+1);
editDistI = zeros(length1+1, length2+1);
pathM = zeros(length1+1, length2+1);
pathD = zeros(length1+1, length2+1);
pathI = zeros(length1+1, length2+1);


for k = 2:21
    
    mat = subMatInput{k}';
    for j = 2:21
        subMatrix(k-1,j-1) = str2double(mat(j));
    end
    
end

    %S(x_i,y_j)
    function S = getSubVal(A,B)
        indx1 = 3;
        indx2 = 4;
        for p = 2:21
            %If letter equals variable save index
            if(strcmp(letterArray(p),A))
                indx1 = p;
            end
            
            if(strcmp(letterArray(p),B))
                indx2 = p;
            end
        end

        S = subMatrix(indx1-1, indx2-1); 
    end


%boundary conditions
for i = 1:length1
    
    editDistM(i+1,1) = -inf;
    
    editDistD(i+1,1) = -inf;
    
    editDistI(i+1,1) = lambda(i);
    pathI(i+1,1) = 'I';
end

for j = 1:length2
    
    editDistM(1,j+1) = -inf;
    
    editDistD(1,j+1) = lambda(j);
    pathD(1,j+1) = 'D';
    
    editDistI(1,j+1) = -inf;
end

%Fill the three memorization matrices
for i = 1:length1
   for j = 1:length2
       
       %obtain value from substitution matrix
       subVal = getSubVal(seqOne(i),seqTwo(j));
       
       editDistM(i+1, j+1) = max([editDistM(i,j) + subVal, editDistD(i,j) + subVal, editDistI(i,j) + subVal]);
       if(editDistM(i+1, j+1) == editDistM(i,j) + subVal)
           pathM(i+1, j+1) = 'M';
       elseif(editDistM(i+1, j+1) == editDistD(i,j) + subVal)
           pathM(i+1, j+1) = 'D';
       else
           pathM(i+1, j+1) = 'I';
       end
       
       editDistD(i+1, j+1) = max([editDistM(i+1,j) + go, editDistD(i+1,j) + ge, editDistI(i+1,j) + go]);
       if(editDistD(i+1, j+1) == editDistM(i+1,j) + go)
           pathD(i+1, j+1) = 'M';
       elseif(editDistD(i+1, j+1) == editDistD(i+1,j) + ge)
           pathD(i+1, j+1) = 'D';
       else
           pathD(i+1, j+1) = 'I';
       end
       
       editDistI(i+1, j+1) = max([editDistM(i,j+1) + go, editDistD(i,j+1) + go, editDistI(i,j+1) + ge]);
       if(editDistI(i+1, j+1) == editDistM(i,j+1) + go)
           pathI(i+1, j+1) = 'M';
       elseif(editDistI(i+1, j+1) == editDistD(i,j+1) + go)
           pathI(i+1, j+1) = 'D';
       else
           pathI(i+1, j+1) = 'I';
       end
       
   end
end

%editDistM
%pathM
%editDistD
%pathD
%editDistI
%pathI

%backtracking - find max corner value then back track from there
%indexes
ind1 = length1+1;
ind2 = length2+1;

align1 = '';
align2 = '';

maxDist = max([editDistM(ind1,ind2),editDistD(ind1, ind2),editDistI(ind1, ind2)]);
optimalScore = maxDist;
if(maxDist == editDistM(ind1,ind2))
   currPath = 'M';
elseif(maxDist == editDistD(ind1, ind2)) 
   currPath = 'D';
else
   currPath = 'I';
end

%using the path memorisation matrices to obtain optimal alignment
while(ind1 ~= 0 && ind2 ~= 0)
    
    if(currPath == 'M')
        align1 = strcat(seqOne(ind1-1),align1);
        align2 = strcat(seqTwo(ind2-1),align2);
        currPath = pathM(ind1,ind2);
        if(ind1 > 2 && ind2 > 2)
            ind1 = ind1 - 1;
            ind2 = ind2 - 1;
       else
           break;
       end
    elseif(currPath == 'D')
        if(ind2-1 ~= 0)
            align1 = strcat('_',align1);
            align2 = strcat(seqTwo(ind2-1),align2);
            currPath = pathD(ind1,ind2);
        end
       
       ind2 = ind2 - 1;
    else
       if(ind1-1 ~= 0)
            align1 = strcat(seqOne(ind1-1),align1);
            align2 = strcat('_',align2);
            currPath = pathI(ind1,ind2);
       end
       
       ind1 = ind1 - 1;
    end
    
    
end



fprintf('Sequence one: %s\n', seqOne);
fprintf('Sequence two: %s\n', seqTwo);
fprintf('g_o: %i\n', go);
fprintf('g_e: %i\n', ge);
fprintf('Optimal Alignment score: %f\n', optimalScore);
fprintf('Optimal Alignment: \n');
fprintf('%s\n', align1);
fprintf('%s\n', align2);

end