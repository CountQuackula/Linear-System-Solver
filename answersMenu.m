function [mainMenu] = answersMenu(augmentedMatrix, reducedMatrix, ...
        mainMenu, bValue, solsFOut, solsFPlot)
    %this function displays and manages the linear system solver progarm
    %GUI after the system has been solved

    %initilizing a vector to act as a function for switching between pages
    %in this menu
    pressedRightArrow = [2, 3, 4, 1];
    pressedLeftArrow = [4, 1, 2, 3];

    %initilizing page variable to keep numerical track of which page user
    %is on in this menu
    page = 1;

    %initilizing variable plotDimension to track which type of plooting
    %function to use in MatLab
    plotDimension = "";

    %initilizing all variables required for plotting
    x1 = 0;
    x2 = 0;
    x3 = 0;
    x = 0;
    y = 0;
    z = 0;
    
    %setting menu array to desired size for all pages of this menu
    menu = ones(size(augmentedMatrix, 1) + 1, size(augmentedMatrix, 2), 3);

    %clearing previous image and then displaying new image/menu array this
    %is the initial output image
    clf(mainMenu);
    axes('Position', [0 0 1 1]);
    image(menu);
    text(1, size(augmentedMatrix, 1) + 1, 'Original Matrix');

    %using text() in for loops to display matrix elements in appropriate
    %cells
    for i = 1:1:size(augmentedMatrix, 1)
        for j = 1:1:size(augmentedMatrix, 2)
            text(j, i, string(augmentedMatrix(i,j)));
        end
    end

    %narrowing the type of plot required if any and setting variable values
    %accordingly narrows plot required to 2D dot
    if size(augmentedMatrix, 2) - bValue == 2 && ...
            ~contains("no solution/s exist", solsFOut) && ...
            ~contains("free variable", solsFPlot)

        %setting x(1:n) value using entries in solsForPlotting
        %array, based on bValue
        if bValue == 1
            x1 = str2double(solsFPlot(1,1));
            x2 = str2double(solsFPlot(2,1));
        end

        %setting x and y values for plot as a square dot using meshgrid()
        x = x1 - 0.25 : 0.01 : x1 + 0.25;
        y = x2 - 0.25 : 0.01 : x2 + 0.25;
        [x, y] = meshgrid(x, y);
        
        %setting the required plot to 2D
        plotDimension = "2D";

    %narrows plot required to 2D line with y as free variable
    elseif size(augmentedMatrix, 2) - bValue == 2 && ...
            ~contains("no solution/s exist", solsFOut) && ...
            contains("free variable", solsFPlot(1,1))

        %setting x(1:n) value using entries in solsForPlotting
        %array, based on bValue
        if bValue == 1
            x2 = str2double(solsFPlot(2,1));
        end

        %setting values of x and y in case of x being free variable
        x = -10 : 0.01 : 10;
        y = x2 + str2double(solsFPlot(2,2)) * x;

        %setting required plot to 2D
        plotDimension = "2D";
    
    %narrows required plot to 2D line with x as free variable
    elseif size(augmentedMatrix, 2) - bValue == 2 && ...
            ~contains("no solution/s exist", solsFOut) && ...
            contains("free variable", solsFPlot(2,1))

        %case of 2D line
        if bValue == 1
            x1 = str2double(solsFPlot(1,1));
        end

        %setting values of x and y in case of y being free variable
        y = -10 : 0.01 : 10;
        x = x1 + str2double(solsFPlot(1,3)) * y;
        
        %setting required plot to 2D
        plotDimension = "2D";

    %narrows plot to 3D dot
    elseif size(augmentedMatrix, 2) - bValue == 3 && ...
            ~contains("no solution/s exist", solsFOut) && ...
            ~contains("free variable", solsFPlot)

        %if given values for x1-x3 setting them to x1-x3
        if bValue == 1
                x1 = str2double(solsFPlot(1,1));
                x2 = str2double(solsFPlot(2,1));
                x3 = str2double(solsFPlot(3,1));
        end

        %setting values for x, y and z then making desired radius
        [x, y, z] = sphere;
        x = x * 0.25 + x1;
        y = y * 0.25 + x2;
        z = z * 0.25 + x3;
        
        %setting required plot to a 3D line plot
        plotDimension = "3Ddot";

    %narrows to 3D plot of a line with z as the only free variable
    elseif size(augmentedMatrix, 2) - bValue == 3 && ...
            ~contains("no solution/s exist", solsFOut) && ...
            contains("free variable", solsFPlot(3, 1)) && ...
            ~contains("free variable", solsFPlot(2, 1)) && ...
            ~contains("free variable", solsFPlot(1, 1))

        %setting default or central values of plot based on presence of
        %b column vector or not
        if bValue == 1
                x1 = str2double(solsFPlot(1,1));
                x2 = str2double(solsFPlot(2,1));
        end
        
        %setting values for x, y and z
        z = -10 : 0.01 : 10;
        x = x1 + str2double(solsFPlot(1,4)) * z;
        y = x2 + str2double(solsFPlot(2,4)) * z;
        
        %setting required plot to a 3D line plot
        plotDimension = "3Dline";

    %narrows to 3D plot of a line with y as the only free variable
    elseif size(augmentedMatrix, 2) - bValue == 3 && ...
            ~contains("no solution/s exist", solsFOut) && ...
            contains("free variable", solsFPlot(2, 1)) && ...
            ~contains("free variable", solsFPlot(1, 1)) && ...
            ~contains("free variable", solsFPlot(3, 1))

        %setting default or central values of plot based on presence of
        %b column vector or not
        if bValue == 1
            x1 = str2double(solsFPlot(1,1));
            x3 = str2double(solsFPlot(3,1));
        end
        
        %setting values of x, y and z
        y = -10 : 0.01 : 10;
        x = x1 + str2double(solsFPlot(1,3)) * y;
        z = x3 + str2double(solsFPlot(3,3)) * y;
        
        %setting required plot to 3D line plot
        plotDimension = "3Dline";

    %narrows to 3D plot of a line with x as the only free variable
    elseif size(augmentedMatrix, 2) - bValue == 3 && ...
            ~contains("no solution/s exist", solsFOut) && ...
            contains("free variable", solsFPlot(1, 1)) && ...
            ~contains("free variable", solsFPlot(2, 1)) && ...
            ~containts("free variable", solsFPlot(3, 1))

        %setting default or central values of plot based on presence of
        %b column vector or not
        if bValue == 1
            x2 = str2double(solsFPlot(2,1));
            x3 = str2double(solsFPlot(3,1));
        end
        
        %setting x, y and z values
        x = -10 : 0.01 : 10;
        y = x2 + str2double(solsFPlot(1,2)) * x;
        z = x3 + str2double(solsFPlot(3,2)) * x;
        
        %setting required plot to a 3D line plot
        plotDimension = "3Dline";
    
    %case of plot being a plane
    elseif size(augmentedMatrix, 2) - bValue == 3 && ...
            ~contains("no solution/s exist", solsFOut) && ...
            contains("free variable", solsFPlot)
        
        %detemining which variable isnt a free variable using reduced
        %matrix then setting the equations and value for each variable
        for i = 1:1:size(reducedMatrix, 2) - bValue
            %determining which variable isnt the free varialbe of the plane
            if reducedMatrix(1, i) == 1 && i == 3
                %setting the z value equation if given a value from the
                %matrix
                if bValue == 1
                    x3 = str2double(solsFPlot(3,1));
                end
                
                %setting the x, y and z variable values
                x = -10 : 0.01 : 10;
                y = -10 : 0.01 : 10;
                z = x3 + str2double(solsFPlot(3,2)) * x + ...
                    str2double(solsFPlot(3,3)) * y;
                
                %creating a meshgrid of the free variables
                [x, y] = meshgrid(x, y);

                %breaking out of the for loop since only 1 non-free
                %variable exists
                break;
            elseif reducedMatrix(1, i) == 1 && i == 2
                %setting the z value equation if given a value from the
                %matrix
                if bValue == 1
                    x2 = str2double(solsFPlot(2,1));
                end
                
                %setting the x, y and z variable values
                x = -10 : 0.01 : 10;
                z = -10 : 0.01 : 10;
                y = x2 + str2double(solsFPlot(2,2)) * x + ...
                    str2double(solsFPlot(2,4)) * z;
                
                %creating a meshgrid of the free variables
                [x, z] = meshgrid(x, z);

                %breaking out of the for loop since only 1 non-free
                %variable exists
                break;
            elseif reducedMatrix(1, i) == 1 && i == 1
                %setting the z value equation if given a value from the
                %matrix
                if bValue == 1
                    x1 = str2double(solsFPlot(1,1));
                end
                
                %setting the x, y and z variable values
                y = -10 : 0.01 : 10;
                z = -10 : 0.01 : 10;
                x = x1 + str2double(solsFPlot(1,3)) * y + ...
                    str2double(solsFPlot(1,4)) * z;
                
                %creating a meshgrid of the free variables
                [y, z] = meshgrid(y, z);

                %breaking out of the for loop since only 1 non-free
                %variable exists
                break;
            end
        end
        
        %setting required plot value as the plot3 function works for planes
        %and lines
        plotDimension = "3Dline";

    %case where plot is not possible due to to many dimensions in the
    %system or solutions not existing page 4 is not allowed
    else
        pressedRightArrow = [2, 3, 1];
        pressedLeftArrow = [3, 1, 2];
    end
    
    %using while loop to allow user to cycle through menus as long as they
    %please
    while true
        %waiting for user input then updating the value of keyPressed
        waitforbuttonpress;

        %retrieving the users pressed key
        keyPressed = guidata(mainMenu);

        %switching between pages horizontally depending on button pressed
        %or plotting solution where possible
        if keyPressed == "leftarrow"
            %assigning new page value
            page = pressedLeftArrow(page);

        elseif keyPressed == "rightarrow"
            %assigning new page value
            page = pressedRightArrow(page);
        elseif keyPressed == "escape"
            %stopping this menu from running and clearing this figure
            clf(mainMenu);

            %breaking out of while loop to exit function
            break;
        end

        %clearing keyPressed variable so that when using built in plot
        %inspenction tools the button press isnt tirggered causing page
        %movment
        keyPressed = "";
        guidata(mainMenu, keyPressed);

        %setting new page
        if page == 1
            %clearing previous image and then displaying new image/menu
            clf(mainMenu);
            axes('Position', [0 0 1 1]);
            image(menu);
            text(1, size(augmentedMatrix, 1) + 1, 'Original Matrix');

            %using text() in for loops to display matrix elements in
            %appropriate cells on figure/GUI
            for i = 1:1:size(augmentedMatrix, 1)
                for j = 1:1:size(augmentedMatrix, 2)
                    text(j, i, string(augmentedMatrix(i,j)));
                end
            end

        elseif page == 2
            %clearing previous image and then displaying new image/menu
            clf(mainMenu);
            axes('Position', [0 0 1 1]);
            image(menu);
            text(1, size(augmentedMatrix, 1) + 1, 'Solved/Reduced Matrix');

            %using text() in for loops to display matrix elements in
            %appropriate cells on figure/GUI
            for i = 1:1:size(reducedMatrix, 1)
                for j = 1:1:size(reducedMatrix, 2)
                    text(j, i, string(reducedMatrix(i,j)));
                end
            end
        elseif page == 3
            %creating custom menu array for this menu
            menu = ones(size(solsFOut, 1) + 1, 1, 3);

            %clearing previous image and then displaying new image/menu
            clf(mainMenu);
            axes('Position', [0 0 1 1]);
            image(menu);
            text(0.75, size(solsFOut, 1) + 1, 'Solutions');

            %setting menus ack to default size so other parts of the code
            %arent in conflict
            menu = ones(size(augmentedMatrix, 1) + 1, ...
                size(augmentedMatrix, 2), 3);

            %using text() in for loops to display matrix elements in
            %appropriate cells on figure/GUI
            for i = 1:1:size(solsFOut, 1)
                text(0.75, i, solsFOut(i));
            end
        elseif page == 4
            %clearing previous images etc off GUI
            clf(mainMenu);

            %determining required plot and plotting it on the GUI
            if plotDimension == "2D"
                %plotting and setting plot labels while leaving viewing
                %window on auto
                plot(x, y);
                grid on;

                %adding axes labels
                xlabel('x-axis');
                ylabel('y-axis');
                
            elseif contains(plotDimension, "3D")            
                %plotting in 3D either a dot or line
                if contains(plotDimension, "dot")
                    %creating the plot of dot on figure/GUI
                    surf(x, y, z);

                    %setting reasonable sized viewing window for the dot
                    xlim([x1-10, x1+10]);
                    ylim([x2-10, x2+10]);
                    zlim([x3-10, x3+10]);
                    grid on;
                elseif contains( plotDimension, "line")
                    %creating the 3D plot line
                    plot3(x, y, z);
                    grid on;
                end
    
                %adding labels and leaving viewing window on auto
                xlabel('x-axis');
                ylabel('y-axis');
                zlabel('z-axis');
            end
        end
    end
end