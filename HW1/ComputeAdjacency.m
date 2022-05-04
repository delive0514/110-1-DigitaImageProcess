function [ labels ] = ComputeAdjacency( x , csvPath )
    inputArray = csvread(csvPath);
    disp('inputArray=');
    disp(inputArray);
    connect = x;    
    [x,y] = size(inputArray);
    inputArray = [zeros(1,y+2);[zeros(x,1) inputArray zeros(x,1)]];
    [x,y] = size(inputArray);
    labels = zeros(size(inputArray));
    nextlabel = 1;
    connected = [];
    for i = 2:x                       
        for j = 2:y-1                 
            if inputArray(i,j) ~= 0         
                if (connect == 8)
                    next = [inputArray(i-1,j-1), inputArray(i-1,j), inputArray(i-1,j+1),inputArray(i,j-1)];
                elseif (connect == 4)
                    next = [inputArray(i-1,j),inputArray(i,j-1)];
                end           
                [~,n,neighbours] = find(next==1);
                if isempty(neighbours)
                    connected{nextlabel} = nextlabel;
                    labels(i,j) = nextlabel;
                    nextlabel = nextlabel+1;                
                else
                    if (connect == 8)
                        next_label = [labels(i-1,j-1), labels(i-1,j), labels(i-1,j+1),labels(i,j-1)];
                    elseif (connect == 4)
                        next_label = [labels(i-1,j), labels(i,j-1)];
                    end
                    L = next_label(n);
                    labels(i,j) = min(L);
                    for k = 1:length(L)
                        label = L(k);
                        connected{label} = unique([connected{label} L]);
                    end                
                end
            end
        end
    end
    labels = labels(2:end,2:end-1);
    
    change2 = 1;
    while change2 == 1
        change = 0;
        for i = 1:length(connected)
            for j = 1:length(connected)
                if i ~= j
                    if sum(ismember(connected{i},connected{j}))>0 && sum(ismember(connected{i},connected{j})) ~= length(connected{i})
                        change = 1;
                        connected{i} = union(connected{i},connected{j});
                        connected{j} = connected{i};
                    end
                end
            end
        end

        if change == 0
            change2 = 0;
        end
    end    
    connected = unique(cellfun(@num2str,connected,'UniformOutput',false));
    connected = cellfun(@str2num,connected,'UniformOutput',false);
    K = length(connected);
    templabels = labels;
    labels = zeros(size(labels));
    for k = 1:K
        for l = 1:length(connected{k})
            labels(templabels == connected{k}(l)) = k;
        end
    end
    disp(K)
end

