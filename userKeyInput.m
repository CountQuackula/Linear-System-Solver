function userKeyInput(mainMenu,eventData)
    %this function is a callback in the case of user input via the keyboard
    %for the linear system solver program
    keyPressed = eventData.Key;
    guidata(mainMenu, keyPressed)
end