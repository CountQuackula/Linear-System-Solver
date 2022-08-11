function [reducedMatrix] = ...
    makeReducedRowEchelon(reducedMatrix)
    %makes the input matrix and its parameters into rref
    %taking input matrix and running it through the Gauss-Jordan
    %elimination algorithum determining which row is to be used as the
    %first pivot and carrying out the appropriate row operations to 
    %complete the first pivot

    %initilizing variables to default states
    columns = size(reducedMatrix,2);
    rows = size(reducedMatrix,1);

    %using nested for loops and if statments to determine courses of action
    %and carrying out the calculations
    for i = 1:1:rows
        %going through each value in the column and applying the same
        %calculations to that value as the pivot
        for j = i:1:columns
            currentColumn = i;
            %pivoting without row exchange
            if reducedMatrix(i, j) ~=0
                %turning the row pivot into a 1 and appling across the
                %columns
                reducedMatrix(i,:) = reducedMatrix(i,:) / ...
                    reducedMatrix(i,j);

                %iterating through each row in the whole matrix to subtract
                %the currently pivoted rows scalar multiple
                for k = 1:1:rows
                    %making the row reduction of the whole column
                    %not occur for the pivot row
                    if k ~= i
                        %subtracting pivot row from current non-pivot row
                        reducedMatrix(k,:) = reducedMatrix(k,:) - ...
                            (reducedMatrix(i,:) * ...
                            reducedMatrix(k,j));
                    end
                end
                
                %breaking the for loop through columns after pivoting
                break;
            
            %pivoting with row exchange by going down rows
            elseif j <= rows && reducedMatrix(j, currentColumn) ~= 0
                %switching current row with next row with non-zero entry in
                %pivot column
                reducedMatrix([i j],:) = reducedMatrix([j i],:);

                %making current pivot entery in row after switch 1 and
                %applying across all columns in the row
                reducedMatrix(i,:) = reducedMatrix(i,:) / ...
                    reducedMatrix(i,currentColumn);
                
                %iterating over every row in the matrix to subtract the
                %pivot row from it
                for k = 1:1:rows
                    %making the row reduction of the whole column not occur
                    %for the pivot row
                    if k ~= i
                        %subtracting pivot row from current non-pivot row
                        reducedMatrix(k,:) = reducedMatrix(k,:) - ...
                            (reducedMatrix(i,:) * ...
                            reducedMatrix(k,currentColumn));
                    end
                end

                %breaking the for loop through columns after pivoting
                break;
            end
        end
    end
end