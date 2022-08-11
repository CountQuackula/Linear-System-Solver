function [solsFOut, solsFPlot] =interpretingAugmentedMatrix(reducMat, bVal)
    %function for creating interpretations of augmentedMatrix
    %used to keep track of where pivots are
    pivoted = false;

    %stores solutions as strings in a column vector
    solsFOut = string(zeros(size(reducMat,2)-bVal,1));
    
    %setting to dafault value of empty row
    xj = "free variable";

    %used for concatonation of free variable into sFP solution
    freeVar = string([]);

    %setting solutions for plotting to desired size
    solsFPlot =string(zeros(size(reducMat,2)-bVal,size(reducMat,2)+~bVal));
        
    %filling freeVar to be same size as sFP columns
    for k = 1:1:size(reducMat,2) + ~bVal
        freeVar = [freeVar "free variable"];
    end

    %uses i to track row in reducMat
    for i = 1:1:size(reducMat,1)
        %used to track which varialbe is currently being checked for
        %solution/s
        currentCol = i;

        %checking if this row has solution/s
        if sum(abs(reducMat(i,[1:size(reducMat,2)-bVal])))~=0
            %setting appropriate value for solsFPlot cell
            solsFPlot(currentCol,1) =string(reducMat(i,size(reducMat,2)));

            %setting constant in solsFPlot is solutions present
            for j = 1:1:size(reducMat,2)-bVal
                %case of finding pivot in a column when matrix is [A|b]
                if reducMat(i,j)==1 && pivoted==false && bVal == 1
                    pivoted=true;
                    xj = strcat("x", string(currentCol), "=", ...
                        string(reducMat(i,size(reducMat,2))));

                %case of finding pivot in a column when matrix is [A]
                elseif reducMat(i,j)==1 && pivoted==false && bVal == 0
                    %setting pivoted to true so progarm behaves
                    %differently after having pivoted
                    pivoted=true;
   
                    %starting string of equation for solsFOut
                    xj = strcat("x", string(currentCol), "=b", string(i));
    
                    %setting solsFPlot appropriate cell to be bi
                    solsFPlot(currentCol,1) = strcat("b", string(i));
                
                %case of non-zero entry post pivot
                elseif reducMat(i,j) ~= 0 && pivoted==true
                    %case of free variable in non zero column vector
                    %post pivot
                    xj = strcat(string(xj), "+", "(", ...
                        string(-reducMat(i,j))," * x",string(j), ")");
                    solsFOut(j,1) = "free variable";
                    solsFPlot(currentCol,j+1) = string(-reducMat(i,j));
                    solsFPlot(j,:) = freeVar;
                
                %case of entirely empty column post pivot
                elseif reducMat(i,j) == 0 && pivoted == true && ...
                        sum(abs(reducMat(:,j))) == 0
                    %case of free variable in 0 column vector post
                    %pivot
                    solsFOut(j,1) = "free variable";
                    solsFPlot(j,:) = "free variable";
                end
            end

            %saving equation for xj in sFO
            solsFOut(currentCol,1) = xj;

            %setting back to default value
            xj = "free variable";

            %resetting pivoted variable for next row
            pivoted = false;

        %case where matrix isnt of the form [A|b] and has contridictory row
        %meaning no solutions exist
        elseif bVal == 1 && reducMat(i, size(reducMat, 2)) ~= 0
            %outputting to user that system of linear equations entered
            %has no solutions
            solsFOut = "no solution/s exist";

            %emptying plotting array as not plot can be generated
            %without solution/s
            solsFPlot(:,:) = [""];
        end
    end
end