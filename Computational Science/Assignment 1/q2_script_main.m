%Neel Patel
%24176540

A = q2_parser('A.pdb');
B = q2_parser('B.pdb');

%print subset of vectors of length k
output = [];
length(A)
length(B)

%set up counts and rmsdLast array
maxsupCount = 0;
rmsdLast = [];
contiguousIndex = 0;
contigCount = 0;
len = min(length(A),length(B));

for k = len-1:-1:6
    for i = 1:length(A)-k
        for j = 1:length(B)-k
            U = A(i:i+k,:);
            V = B(j:j+k,:);

            %checks if contiguous maximal superimposable frag pairs
            %exceeded the threshold
            if contiguousIndex ~= j-1 && contigCount > 0
                maxsupCount = maxsupCount + 1;
                output = [output; rmsdLast];
                contigCount = 0;
            end
            
            rmsd = q2_rmsd(U,V);
            if rmsd < 1.2
                %saves the last rmsd
                rmsdLast = [i,j,k,rmsd];
                contiguousIndex = j;
                contigCount = contigCount+1;
            end
        end
    end
end


output
maxsupCount

%outputs file , one maximal superimposable fragment per entry
fid = fopen('q2_output.txt','wt');  % Note the 'wt' for writing in text mode
fprintf(fid,'%f\n',maxsupCount);
for i = 1:length(output)
    fprintf(fid,'%i ',output(i,1:3));
    fprintf(fid,'%g ',output(i,4));
    fprintf(fid,'\n');
end

fclose(fid);
