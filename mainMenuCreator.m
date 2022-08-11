function [mainMenu] = mainMenuCreator()
    %this function creates, operates on and updates a GUI for a system of
    %linear equation solver program

    %initilizing an empty 3D RGB matrix to use as the data for the image
    menu = ones(20, 17, 3);

    %using k to track state of robots arms which is raised and which is
    %lowered
    k = 1;

    %opening a figure to use as the GUI and assigning it the handle
    %mainMenu
    mainMenu = figure('Units','normalized','Position',[1/4 1/4 1/2 1/2]);
    
    %initilizing a variable keyPressed to store user key input
    keyPressed = "";
    guidata(mainMenu, keyPressed);

    %setting callBack functions for key presses for the GUI to userKeyInput
    set(mainMenu,'WindowKeyPressFcn', @userKeyInput)

    %opening the menu array as an image in the figure created above after
    %setting the image boundries to the the entire figure space
    axes('Position', [0 0 1 1]);
    image(menu);

    %adding text as an instructions page to the above image
    text(2, 3, "Instructions! MUST READ!", 'FontSize', 16);
    text(2, 6, "Use left and right arrow keys to navigate between pages.");
    text(2, 9, "Use up and down arrow keys to move between " + ...
        "options/buttons on a page where applicable.");
    text(2, 12, "Press enter on a menu to move to the next step/s and " +...
        "confirm the currently selected option/button.");
    text(2, 15, "You can enter numerical values using the number " + ...
        "keys when prompted.");
    text(2, 18, "Press escape on the menu displaying solutions to be " + ...
        "able to select a different menu.");

    %waiting in a while loop until enter key is pressed to continue
    while true
        waitforbuttonpress;
        keyPressed = guidata(mainMenu);
        if keyPressed == "return"
            break;
        end
    end
    
    %clearning keyPressed variable to not carry over previous value to next
    %logic gate causing sections of code to be unintentionally skipped
    keyPressed = "";
    guidata(mainMenu, keyPressed);

    %initilizing series of variables as cartesian coordinates within the
    %menu matrix using x and y as vector variables to create a robot logo
    %on the GUI
    yRobotBody1 = [3 11 18];
    yRobotBody2 = [3:5 10:12 18];
    yRobotBody3 = [5:7 9:18];
    yRobotBody4 = (5:13);
    yRobotBody5 = [5:7 9:18];
    yRobotBody6 = [3:5 10:12 18];
    yRobotBody7 = [3 11 18];
    yRobotArm1 = (7:8);
    yRobotArm2 = (8:11);
    yRobotArm3 = [7:8 11];
    yRobotArm4 = [11 14:15];
    yRobotArm5 = (11:14);
    yRobotArm6 = (14:15);
    
    %transforming menu array to include RGB image of a robot
    for j = 1:1:3
        pixelValue = rand();
        menu(yRobotBody1, 6, j) = pixelValue;
        menu(yRobotBody2, 7, j) = pixelValue;
        menu(yRobotBody3, 8, j) = pixelValue;
        menu(yRobotBody4, 9, j) = pixelValue;
        menu(yRobotBody5, 10, j) = pixelValue;
        menu(yRobotBody6, 11, j) = pixelValue;
        menu(yRobotBody7, 12, j) = pixelValue;
        menu(yRobotArm1, 4, j) = pixelValue;
        menu(yRobotArm2, 5, j) = pixelValue;
        menu(yRobotArm3, 6, j) = pixelValue;
        menu(yRobotArm4, 12, j) = pixelValue;
        menu(yRobotArm5, 13, j) = pixelValue;
        menu(yRobotArm6, 14, j) = pixelValue;
    end

    %outputting the robot generated above in the menu array to the GUI
    clf(mainMenu);
    axes('Position',[1/4 0 1/2 1]);
    image(menu);
    
    %indefinetly changing the robots arm colour and position till a key is
    %pressed
    while true
        keyPressed = guidata(mainMenu);
        if keyPressed == "return"
            clf(mainMenu); %clearing images to avoid memory leak
            axes('Position',[0 0 1 1]);
            break;
        end
        
        %pausing code to give apperance of animation
        pause(0.25);

        %setting the previous values for the arms to white like background
        menu(yRobotArm1, 9+((-1)^k)*5, :) = 1;
        menu(yRobotArm2, 9+((-1)^k)*4, :) = 1;
        menu(yRobotArm3, 9+((-1)^k)*3, :) = 1;
        menu(yRobotArm4, 9-((-1)^k)*3, :) = 1;
        menu(yRobotArm5, 9-((-1)^k)*4, :) = 1;
        menu(yRobotArm6, 9-((-1)^k)*5, :) = 1;

        %creating and saving new colour values of robots arms
        for j = 1:1:3
            %assigning a random R, G or B 0-1 value on each iteration
            %through the 3rd dimension of the array
            pixelValue = rand();
            %setting new values of arms from random generation
            menu(yRobotArm1, 9-((-1)^k)*5, j) = pixelValue;
            menu(yRobotArm2, 9-((-1)^k)*4, j) = pixelValue;
            menu(yRobotArm3, 9-((-1)^k)*3, j) = pixelValue;
            menu(yRobotArm4, 9+((-1)^k)*3, j) = pixelValue;
            menu(yRobotArm5, 9+((-1)^k)*4, j) = pixelValue;
            menu(yRobotArm6, 9+((-1)^k)*5, j) = pixelValue;
        end
        
        %updating image of robot
        clf(mainMenu); %clearing previous images to avoid memory leak
        axes('Position',[1/4 0 1/2 1]);
        image(menu);

        %switching value of k for next loop to change arm positions
        k = ~k;
    end
end