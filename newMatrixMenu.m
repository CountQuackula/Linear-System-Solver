function [mainMenu, augmentedMatrix, bValue] = ...
        newMatrixMenu(mainMenu,option)
    %this function gets user input on dimesnion sizes for the system of
    %linear equations and depending on the option selected in the
    %optionsMenu function will either create a random matrix or ask the
    %user to input the elements of one of the specified size

    %initilizing row and column size variables and other miscelanous
    %variables
    rows = "";
    columns = "";
    minimum = "";
    maximum = "";
    elementValue = ''; %temporarily stores the value of an array element
    negative = false; %tracks whether a negitve sign has been added to
    %minimum or maximum variables for random matrix generation
    bValue = 2; %setting bValue to a non-consiquential value so that
    %further loops work in this function
    
    %setting menu array to be a white image and clearing old image then
    %setting new image on figure with text overlay
    menu = ones(5, 5, 3);
    clf(mainMenu);
    axes('Position', [0 0 1 1]);
    image(menu);
    text(1, 2, 'Enter the amount of rows:');

    %storing amount of rows of matrix by concatonation
    while true
        %waiting for user to input a key press
        waitforbuttonpress;

        %retrieving the users key input
        keyPressed = guidata(mainMenu);

        %determining if user has entered rows value and wishes to proceed
        %to columns or is adding values to the amount of rows
        if keyPressed == "return" && rows ~= ""
            break;
        elseif contains("1234567890", keyPressed)
            %concatonating the number pressed by user to the end of the
            %rows string
            rows = strcat(rows, keyPressed);

            %outputting new amount of rows entered by user so far by
            %clearing then updating the display
            clf(mainMenu);
            axes('Position', [0 0 1 1]);
            image(menu);
            text(1, 2, 'Enter the amount of rows:');
            text(1, 3, rows);
        end
    end

    %making the rows variable numerical rather than a string
    rows = str2double(rows);

    %clearing old image then setting new image on figure with text overlay
    %to ask user for amount of columns in their matrix
    clf(mainMenu);
    axes('Position', [0 0 1 1]);
    image(menu);
    text(1, 2, 'Enter the amount of columns:');

    %storing amount of columns of matrix by concatonation similar to rows
    while true
        %waiting for user to input a key press
        waitforbuttonpress;

        %retrieving the users key input
        keyPressed = guidata(mainMenu);

        %determining if user has entered columns value and wishes to
        %proceed to the matrix itself or is adding values to the amount of
        %columns
        if keyPressed == "return" && columns ~= ""
            break;
        elseif contains("1234567890", keyPressed)
            %concatonating the number pressed by user to the end of the
            %columns string
            columns = strcat(columns, keyPressed);

            %outputting new amount of columns entered by user so far by
            %clearing then updating the display
            clf(mainMenu);
            axes('Position', [0 0 1 1]);
            image(menu);
            text(1, 2, 'Enter the amount of columns:');
            text(1, 3, columns);            
        end
    end

    %making the columns varible a number rather than string
    columns = str2double(columns);
    
    %initilizing empty matrix of size rows by columns to avoid errors when
    %assigning values by user input or option = 2 case
    augmentedMatrix = zeros(rows, columns);

    %creating matrix by either user specified input or random based on the
    %value of option
    if option == 1
        %clearing old output and displaying new minimum value
        clf(mainMenu);
        axes('Position', [0 0 1 1]);
        image(menu);
        text(1, 2, 'Enter the minimum value:');

        %entering minimum value for matrix elements
        while true
            %awaiting user to input a value
            waitforbuttonpress;

            %retrieving the key input from the user
            keyPressed = guidata(mainMenu);

            %determining whether user input a value or has finished
            %entering the minimum value
            if keyPressed == "return" && minimum ~= "" && minimum ~= "-"
                %if user has entered a value for minimum and presses enter
                %then breaking out of the while loop
                break;

            elseif contains("1234567890", keyPressed)
                %concatonating the number user input to the minimum string
                minimum = strcat(minimum, keyPressed);

                %outputting minimum value entered by user so far
                clf(mainMenu);
                axes('Position', [0 0 1 1]);
                image(menu);
                text(1, 2, 'Enter the minimum value:');
                text(1, 3, minimum);
            elseif contains("hyphen", keyPressed) && negative == false
                %concatonating a negative sign on the end of the minimum
                %number
                minimum = strcat("-", minimum);

                %outputting minimum value entered by user so far
                clf(mainMenu);
                axes('Position', [0 0 1 1]);
                image(menu);
                text(1, 2, 'Enter the minimum value:');
                text(1, 3, minimum);

                %setting negative to true so as to not repeat this statment
                %causeing values like minimum = "--134" etc
                negative = true;
            end
        end
          
        %resetting negative variable to default state
        negative = false;

        %making the minimum variable numerical rather than string
        minimum = str2double(minimum);

        %clearing old output and displaying message prompting user for
        %maximum value
        clf(mainMenu);
        axes('Position', [0 0 1 1]);
        image(menu);
        text(1, 2, 'Enter the maximum value:');

        %entering maximum value for matrix elements in a while loop
        while true
            %waiting for user to input something
            waitforbuttonpress;

            %retrieving the users key stroke from figure key press callback
            keyPressed = guidata(mainMenu);

            %determining whether user has finished entering their maximum
            %value or are still entering more digits
            if keyPressed == "return" && maximum ~= "" && maximum ~= "-"
                %exeting while loop once user has input a maximum value and
                %pressed the enter key
                break;
            elseif contains("1234567890", keyPressed)
                %concatonating nex digit to end of maximium string
                maximum = strcat(maximum, keyPressed);

                %outputting maximum value entered by user so far
                clf(mainMenu);
                axes('Position', [0 0 1 1]);
                image(menu);
                text(1, 2, 'Enter the maximum value:');
                text(1, 3, maximum);
            elseif contains("hyphen", keyPressed) && negative == false
                %concatinating a negative sign on the end of maximum value
                maximum = strcat("-", maximum);

                %outputting maximum value entered by user so far
                clf(mainMenu);
                axes('Position', [0 0 1 1]);
                image(menu);
                text(1, 2, 'Enter the maximum value:');
                text(1, 3, maximum);

                %setting negative to true so as to not repeat and reslt in
                %values like maximum = "--- 14341" etc
                negative = true;
            end
        end

        %making the maximum variable numerical rather than string
        maximum = str2double(maximum);

        %creating the matrix and fool proffing incase maximum<minimum
        if maximum >= minimum
            augmentedMatrix = randi([minimum maximum], rows, columns);
        else
            augmentedMatrix = randi([maximum minimum], rows, columns);
        end

    elseif option == 2
        %looping through the users pre defined matrix size acroos columns
        %then down rows
        for i = 1:1:rows
            for j = 1:1:columns
                %clearing old output and prompting user for the number in
                %the current matrix element
                clf(mainMenu);
                axes('Position', [0 0 1 1]);
                image(menu);
                text(1, 2, 'Enter the value in row ' + string(i) + ...
                    ' & column ' + string(j) + ':');

                %setting to default value between entries/elements
                negative = false;
        
                %entering value for matrix elements using while loop
                while true
                    %waiting for user to input a value
                    waitforbuttonpress;

                    %retrieving users keystroke from window call back fcn
                    keyPressed = guidata(mainMenu);

                    %detemining if user has finished entering element or is
                    %adding another digit
                    if keyPressed == "return" && elementValue ~= "" ...
                            && elementValue ~= "-"
                        %exiting the while loop once an element has a value
                        %and user presses enter key
                        break;
                    elseif contains("1234567890", keyPressed)
                        %concatonating latest enterd digit to end of
                        %current elements value
                        elementValue = strcat(elementValue,keyPressed);

                        %outputting value entered by user so far
                        clf(mainMenu);
                        axes('Position', [0 0 1 1]);
                        image(menu);
                        text(1, 2, 'Enter the value in row ' + ...
                            string(i) + ' & column ' + string(j) ...
                            + ':');
                        text(1, 3, elementValue);
                    elseif contains("hyphen", keyPressed) && ...
                            negative == false
                        %concatonating a negative sign on the end of
                        %current element in user generated matrix
                        elementValue = strcat("-",elementValue);

                        %outputting value entered by user so far
                        clf(mainMenu);
                        axes('Position', [0 0 1 1]);
                        image(menu);
                        text(1, 2, 'Enter the value in row ' + ...
                            string(i) + ' & column ' + string(j) ...
                            + ':');
                        text(1, 3, elementValue);

                        %setting negative to true so as to not repeat and
                        %result in values like elementValue = "----135" etc
                        negative = true;
                    end
                end

                %setting current array element to user value and
                %resetting temporary element value variable to empty
                augmentedMatrix(i,j) = str2double(elementValue);
                elementValue = "";
            end
        end
    end
    
    %displaying image asking user to input whether or not their matirx is
    %of the form [A|b]
    clf(mainMenu);
    axes('Position', [0 0 1 1]);
    image(menu);
    text(1, 2, 'Enter 1 if matrix is of the form [A|b] or else 0:');

    %entering while loop until user inputs a satisfactory bValue
    while true
        %waiting for user input
        waitforbuttonpress

        %retireving user key stroke from window call back fcn
        keyPressed = guidata(mainMenu);

        %if the user enterd a satisfactory value then exiting while loop
        if contains("01", keyPressed)
            bValue = str2double(keyPressed);
            break;
        end
    end
end