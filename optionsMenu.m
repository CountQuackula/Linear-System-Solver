function [mainMenu, option] = optionsMenu(mainMenu)
    %this function takes the mainMenu handle and menu array to create an
    %options screen for the linear system solver program

    %initilizing a variable option to track which option is being hovered
    option = 1;

    %initilizing 2 vectors for transforming options varible based on input
    upArrowPress = [2, 1];
    downArrowPress = [2, 1];

    %clearing and setting GUI to default state and desired size for options
    %menu
    clf(mainMenu);
    axes('Position', [0 0 1 1]);
    menu = ones(20, 20, 3);

    %creating buttons on menu array
    for i = 10:10:20
        menu((i-7:i-2), (4:17), :) = 1;
    end
    
    %setting border around first button as the default hover
    for i = 1:1:2
        pixelValue = rand(); %generates a random R/G or B value each loop
        menu((3:8), [3 18], i) = pixelValue;
        menu([2 9], (3:18), i) = pixelValue;
    end

    %displaying the menu created above
    clf(mainMenu);
    axes('Position',[0 0 1 1]);
    image(menu);

    %adding text for buttons ontop of the button squares
    text(4, 5, 'New Random Matrix', 'FontSize',35);
    text(5, 15, 'New User Matrix', 'FontSize',35);

    %setting a while loop to iterate through the user hovering over buttons
    while true
        %waiting for user to input movement
        waitforbuttonpress

        %retrieving the key pressed by the user
        keyPressed = guidata(mainMenu);

        %removing border from current button
        menu((3 + 10 * (option-1):8 + 10 * (option-1)), [3 18], :) = 1;
        menu([(2 + 10 * (option-1)) (9 + 10 * (option-1))], (3:18), :) = 1;

        %determining which key was pressed and carrying out approriate
        %action
        switch keyPressed
            case "return"
                %setting the menu array to be a white canvas
                menu(:,:,:) = 1;

                %clearing previous image from GUI
                clf(mainMenu);

                %resetting image axes on figure then image on GUI
                axes('Position',[0 0 1 1]);
                image(menu);

                %breaking out of while loop to execute next statments after
                %function call
                break;
            case "uparrow"
                %using the array upArrowPress to transform option to the
                %correct button when switching between buttons
                option = upArrowPress(option);
            case "downarrow"
                %using the array upArrowPress to transform option to the
                %correct button when switching between buttons
                option = downArrowPress(option);
        end

        %updating border around current button
        for i = 1:1:2
            pixelValue = rand();
            menu((3 + 10 * (option-1):8 + 10 * (option-1)), ...
                [3, 18], i) = pixelValue;
            menu([(2 + 10 * (option-1)), (9 + 10 * (option-1))], ...
                (3:18), i) = pixelValue;
        end

        %clearing previous images to avoid memory leak
        clf(mainMenu);

        %setting axes for image display to be the entire figure area
        axes('Position', [0 0 1 1]);

        %updating figure with new option being hovered on
        image(menu);

        %re-adding text to buttons
        text(4, 5, 'New Random Matrix', 'FontSize',35);
        text(5, 15, 'New User Matrix', 'FontSize',35);
    end
end