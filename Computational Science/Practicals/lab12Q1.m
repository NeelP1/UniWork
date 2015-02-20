function lab12Q1(nCities)
%solution to travelling salesman problem is permutation encoding

% randomly generate n cities on a 10x10 grid
% plot coordinates on a cartesian plane

cities = rand(2,nCities);
cities = cities*10;

populationSize = 50;

%can thought of as a x,y plane, can use euclidean formula to find distances


%r=randperm(4)
%generate population
population = [];
for i = 1:populationSize
   chromosome = randperm(nCities);
   population = [population; chromosome]; 
end

iterations = 100;

for k = 1:iterations
    
    [parentOne, parentTwo] = selection();
    newChild = crossover(parentOne, parentTwo);
    newChild = mutation(newChild);
    %acceptance -
    newChild
    tempPopulation = [population; newChild];
    population = newPopulation(tempPopulation);
end


%population

%plot cities after finding shortest length
minDistance = inf;
optimalMember = [];
for i = 1:nCities
    lenth = fitness(population(i,1:nCities));
    
    if lenth < minDistance
        minDistance = lenth;
        optimalMember = population(i,1:nCities);
    end
end

finalMember = zeros(2,nCities + 1);
for i = 1:nCities
           x = cities(1,optimalMember(i));
           y = cities(2,optimalMember(i));
           finalMember(1,i) = x;
           finalMember(2,i) = y;
end
x = cities(1,optimalMember(1));
y = cities(2,optimalMember(1));
finalMember(1,nCities+1) = x;
finalMember(2,nCities+1) = y;

plot(finalMember(1,:),finalMember(2,:));


    %auxillary functions
    function newPop = newPopulation(tempPop)
        memberIndex = 0;
        memberLength = 0;
        
       for indx = 1:length(tempPop)
           
           len = fitness(tempPop(indx,1:nCities));
           
           if len > memberLength
                memberLength = len;
                memberIndex = indx;
           end
       end
       
       newPop = tempPop;
       newPop(memberIndex,:) = [];%delete low fitness member
    end


    function [parent1, parent2] = selection()
        %selection
        parent1 = [];
        parent2 = [];
        parent1Length = inf;
        
        for index = 1:populationSize
            
            len = fitness(population(index,1:nCities));

            if len < parent1Length
                parent2 = parent1;
                parent1Length = len;
                parent1 = population(index,1:nCities);
            end

        end
        
        if isempty(parent2)
            parent2 = parent1;
        end
    end

    function cost = fitness(chromosome)
        cost = 0;
        
        for j = 1:nCities-1
           %d = sqrt((x2 - x1)^2 + (y2 - y1)^2 )
           x2 = cities(1,chromosome(j+1));
           x1 = cities(1,chromosome(j));
           y2 = cities(2,chromosome(j+1));
           y1 = cities(2,chromosome(j));
           
           cost = cost + sqrt((x2 - x1)^2 + (y2 - y1)^2); 
        end
        
        x2 = cities(1,chromosome(1));
        x1 = cities(1,chromosome(nCities));
        y2 = cities(2,chromosome(1));
        y1 = cities(2,chromosome(nCities));
        
        cost = cost + sqrt((x2 - x1)^2 + (y2 - y1)^2);
    end
        
    function offspring = crossover(parent1, parent2)
        probability = rand;
        if probability > 0.75
           %single point crossover
            offspring = [parent1(1,1:length(parent1)/2), parent2(1,(length(parent1)/2)+1:length(parent1))];
        else
            offspring = parent1;
        end
    end

    function chromosome = mutation(chromosome)
        %if probability is satisfied
        if rand > 0.9
            a = randi(nCities);
            newIndex = randi(nCities);
            temp = chromosome(1,newIndex);
            chromosome(1,newIndex) = chromosome(1,a);
            chromosome(1,a) = temp;
        end

    end

end