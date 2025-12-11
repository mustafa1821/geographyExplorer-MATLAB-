% Name:      Mustafa Elshikh, Ava Price
% Date:      December 2024
% Course:    ENGR 1181
% Project:   Geography Explorer
% File:      displayMainMenu.m
% Purpose:   Displays the main menu screen using sprite-based text and
%            handles user selection with validated mouse input

function choice = displayMainMenu(gameScene)
    % This function shows the main menu with three options using
    % retro pixel sprites. It allows the user to use their mouse to make commands, mouse clicks ensure the user
    % selects a valid menu option before returning.
    % Input:gameScene-Simple Game Engine scene object
    % Output:choice-Integer (1=Start Learning, 2=View Progress, 3=Exit)
    
    % Define sprite number identifications for letters and icons
    S = 1017; T = 1018; A = 980; R = 1016;
    V = 1020; I = 988; E = 984; W = 1021;
    P = 1014; O = 1013; G = 986; 
    X = 1022; empty = 1;
    mouse = 510;
    
    % Create 10x10 grid for menu layout
    menuImage = ones(10);
    
    % Row 3: "START" with mouse cursor icon
    menuImage(3, 3:8) = [S T A R T mouse];
    
    % Row 6: "PROGRESS"
    menuImage(6, 2:9) = [P R O G R E S S];
    
    % Row 9: "EXIT"
    menuImage(9, 4:7) = [E X I T];
    
    % Keep asking for input until valid selection is made
    validChoice = 0;
    
    while validChoice == 0
        % Display menu screen
        drawScene(gameScene, menuImage);
        title('Geography Explorer - Main Menu');
        
        % Get mouse click position
        [row, col, button] = getMouseInput(gameScene);
        
        
        % Check which menu option was clicked based on row
        if row >= 2 && row <= 4
            choice = 1;
            validChoice = 1;
            fprintf('Selected: Start Learning\n');
            
        elseif row >= 5 && row <= 7
            choice = 2;
            validChoice = 1;
            fprintf('Selected: View Progress\n');
            
        elseif row >= 8 && row <= 10
            choice = 3;
            validChoice = 1;
            fprintf('Selected: Exit\n');
            
        else
            fprintf('Invalid selection. Please click on START, PROGRESS, or EXIT.\n');
        end
    end
end
