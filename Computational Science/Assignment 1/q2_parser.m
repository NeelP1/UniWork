%Neel Patel
%24176540

function M = q2_parser(file)

%number of rows in the file
fid = fopen(file);
allText = textscan(fid,'%s','delimiter','\n');
numberOfLines = length(allText{1});
fclose(fid);


pdbstruct = pdbread(file);

%molecule viewer
%molviewer(pdbstruct);
%PDBArray = pdbwrite(fileName,pdbstruct); not working

%using pdb functions creates a structure we can use like an object
%easier to read and extract atom information
M = [];
for i = 1:numberOfLines - 1
    if strcmp(pdbstruct.Model.Atom(i).AtomName,'CA')
        M = [M; 
            pdbstruct.Model.Atom(i).X, pdbstruct.Model.Atom(i).Y, pdbstruct.Model.Atom(i).Z];
    end
end
    
end