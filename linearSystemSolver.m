%this is the main script for the linear system solver progarm
%clearing variables and command window
clear;
clc;

%running the first function to create the GUI and open the main menu
[mainMenu] = mainMenuCreator();

%running fucntion to get user input on what kind of matrix they would like
%to load into the program to solve
[mainMenu, option] = optionsMenu(mainMenu);

%opening seperate menu to ask user to inpu their matrix and its form as
% [A|b] or [A]
[mainMenu, augmentedMatrix, bValue] = newMatrixMenu(mainMenu,option);

%running a function to convert input matrix into its reduced row echelon
%form via Gauss-Jordan elimination
[reducedMatrix] = makeReducedRowEchelon(augmentedMatrix);

%passing reduced matrix into a function to interpret the reduced matrix and
%outputs solutions in user friendly form and form suitable for graphing
[solsFOut, solsFPlot] = interpretingAugmentedMatrix(reducedMatrix, bValue);

%passing all necessary variables into a finaly function that updates the
%mainMenu GUI to display answers and plots where possible for the input
%system of linear equations
[mainMenu] = answersMenu(augmentedMatrix, reducedMatrix, ...
    mainMenu, bValue, solsFOut, solsFPlot);

%entering while loop allowing user to jump back to a specific menu
while true
    %clearing previous menu and settign current menu to blank
    clf(mainMenu);
    axes('Position', [0 0 1 1]);
    menu = ones(4, 2, 3);
    image(menu);

    %adding options text to blank menu
    text(1, 1, "Press 1 to go back to pick another matrix source.")
    text(1, 2, "Press 2 to go back to enter another matrix.")
    text(1, 3, "Press 3 to go back to the answers display.")
    text(1, 4, "Press escape to exit the progarm and close all windows.")

    waitforbuttonpress;
    keyPressed = guidata(mainMenu);

    if keyPressed == "1"
        %running fucntion to get user input on what kind of matrix they
        %would like to load into the program to solve
        [mainMenu, option] = optionsMenu(mainMenu);
        
        %opening seperate menu to ask user to inpu their matrix and its
        %form as [A|b] or [A]
        [mainMenu, augmentedMatrix, bValue] = ...
            newMatrixMenu(mainMenu,option);
        
        %running a function to convert input matrix into its reduced row
        %echelon form via Gauss-Jordan elimination
        [reducedMatrix] = makeReducedRowEchelon(augmentedMatrix);
        
        %passing reduced matrix into a function to interpret the reduced
        %matrix and outputs solutions in user friendly form and form
        %suitable for graphing
        [solsFOut, solsFPlot] = ...
            interpretingAugmentedMatrix(reducedMatrix, bValue);
        
        %passing all necessary variables into a finaly function that
        %updates the mainMenu GUI to display answers and plots where
        %possible for the input system of linear equations
        [mainMenu] = answersMenu(augmentedMatrix, reducedMatrix, ...
            mainMenu, bValue, solsFOut, solsFPlot);
    elseif keyPressed == "2"
        %opening seperate menu to ask user to inpu their matrix and its
        %form as [A|b] or [A]
        [mainMenu, augmentedMatrix, bValue] = ...
            newMatrixMenu(mainMenu,option);
        
        %running a function to convert input matrix into its reduced row
        %echelon form via Gauss-Jordan elimination
        [reducedMatrix] = makeReducedRowEchelon(augmentedMatrix);
        
        %passing reduced matrix into a function to interpret the reduced
        %matrix and outputs solutions in user friendly form and form
        %suitable for graphing
        [solsFOut, solsFPlot] = ...
            interpretingAugmentedMatrix(reducedMatrix, bValue);
        
        %passing all necessary variables into a finaly function that
        %updates the mainMenu GUI to display answers and plots where
        %possible for the input system of linear equations
        [mainMenu] = answersMenu(augmentedMatrix, reducedMatrix, ...
            mainMenu, bValue, solsFOut, solsFPlot);
    elseif keyPressed == "3"
        %passing all necessary variables into a finaly function that
        %updates the mainMenu GUI to display answers and plots where
        %possible for the input system of linear equations
        [mainMenu] = answersMenu(augmentedMatrix, reducedMatrix, ...
            mainMenu, bValue, solsFOut, solsFPlot);
    elseif keyPressed == "escape"
        %closing the GUI/figure window
        close(mainMenu);

        %exiting the while loop and ending the script
        break;
    end
end