% Name:      Mustafa Elshikh, Ava Price
% Date:      December 2024
% Course:    ENGR 1181
% Project:   Geography Explorer
% File:      GeographyExplorer_Main.m
% Purpose:   Main driver script that controls game flow, initialization,
%            and main game loop for the Geography Explorer educational game

clc;
clear;
close all;

% Display welcome message
fprintf('  Welcome to Geography Explorer!\n');
fprintf('  Interactive European Learning Game\n');
fprintf('Loading game...\n');

% Initialize Simple Game Engine for menu displays
sSize = 16;
zoom = 5;
bgColor = [0, 0, 0];
gameScene = simpleGameEngine('retro_pack.png', sSize, sSize, zoom, bgColor);

% Load country data from Excel file
countryData = loadCountryData('gameData.xlsx');
fprintf('Successfully loaded %d countries!\n\n', length(countryData));

% Main game loop - allows player to restart after completing
playAgain = 1;

while playAgain == 1
    % Initialize or reset progress tracking for new game
    visitedCountries = false(1, 51);
    completedCount = 0;
    europeBadge = 0;
    rankTitle = 'New Explorer';
    
    % Inner game loop for main gameplay
    inGame = 1;
    
    while inGame == 1
        % Display main menu and get user choice
        choice = displayMainMenu(gameScene);
        
        if choice == 1
            % Start Learning - Interactive map mode
            fprintf('\nOpening interactive map...\n');
            
            mapLoop = 1;
            while mapLoop == 1
                % Display map and get country selection using color mask detection
                selectedCountry = displayInteractiveMap(visitedCountries);
                
                if selectedCountry == 0
                    % User chose to return to main menu
                    mapLoop = 0;
                else
                    % Display detailed information about selected country
                    navChoice = displayCountryInfo(gameScene, countryData, selectedCountry);
                    
                    % Update player's progress and check for achievements
                    [visitedCountries, completedCount, badgeEarned, rankTitle] = ...
                        updateUserProgress(selectedCountry, visitedCountries, completedCount);
                    
                    % Handle navigation based on player choice
                    if navChoice == 1
                        % Continue exploring - stay in map loop
                        continue;
                    elseif navChoice == 2
                        % Return to map
                        continue;
                    else
                        % Return to main menu
                        mapLoop = 0;
                    end
                end
            end
            
        elseif choice == 2
            % View Progress - Show statistics and achievements
            fprintf('\nDisplaying your progress...\n');
            displayProgressScreen(gameScene, completedCount, europeBadge, rankTitle);
            
        else
            % Exit Game - Show thank you screen and quit
            fprintf('\nThank you for exploring!\n');
            
            % Create thank you screen with sprites
            T = 1018; H = 987; A = 980; N = 1012; K = 990;
            Y = 1023; O = 1013; U = 1019; ex = 820;
            smile = 852; trophy = 921;
            
            thankYouImage = ones(10);
            thankYouImage(3, 1:10) = [T H A N K Y O U ex ex];
            thankYouImage(4, 4:5) = [smile trophy];
            
            drawScene(gameScene, thankYouImage);
            title('Thank You for Playing!');
            
            % Brief pause before closing
            pause(2);
            
            inGame = 0;
            playAgain = 0;
        end
    end
end

% Clean up and close
close all;
fprintf('  Geography Explorer has closed.\n');

