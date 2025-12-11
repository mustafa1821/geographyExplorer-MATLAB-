% Name:      Mustafa Elshikh, Ava Price
% Date:      December 2024
% Course:    ENGR 1181
% Project:   Geography Explorer
% File:      displayProgressScreen.m
% Purpose:   Shows comprehensive progress statistics including countries
%            completed, badges earned, and current ranking title

function displayProgressScreen(gameScene, completedCount, europeBadge, rankTitle)
    % Displays the player's current game statistics using Sprites and SGE
    
    % Creates a larger background (14 rows, 20 columns) to fit text
    progressImage = ones(14, 20); 
    
    % Title Section:
    % Use textToSprites to convert strings into sprites
    titleSprites = textToSprites('YOUR PROGRESS');
    % Center the title
    startCol = max(2, 11 - floor(length(titleSprites)/2));
    progressImage(2, startCol:(startCol+length(titleSprites)-1)) = titleSprites;
    
    % Countries Explored Section:
    % Label
    progressImage(4, 2:10) = textToSprites('EXPLORED:');
    
    % The Actual Data
    countStr = sprintf('%d/51', completedCount);
    countSprites = textToSprites(countStr);
    progressImage(4, 12:(11+length(countSprites))) = countSprites;
    
    % Percentage Section:
    % Label
    progressImage(6, 2:6) = textToSprites('DONE:');
    
    % The Actual Data
    percentVal = (completedCount/51) * 100;
    percentStr = sprintf('%.0f%%', percentVal); % Round to nearest whole number
    pctSprites = textToSprites(percentStr);
    progressImage(6, 12:(11+length(pctSprites))) = pctSprites;

    % Rank Section:
    % Label
    progressImage(8, 2:6) = textToSprites('RANK:');
    
    % The Rank Title (tracked in updateUserProgress)
    rankSprites = textToSprites(rankTitle);
    % Check if rank is too long, if so, put it on the next line
    %If length exceeds 13, program will crash.
    if length(rankSprites) > 13
         progressImage(9, 2:(1+length(rankSprites))) = rankSprites;
    else
         progressImage(8, 8:(7+length(rankSprites))) = rankSprites;
    end
    
    % Badge Section:
    % If badge earned, show Trophy, Smile, and Text
    trophy = 921;
    smile = 852;
    
    if europeBadge == 1
        % Show visuals
        progressImage(11, 8) = trophy;
        progressImage(11, 9) = smile;
        progressImage(11, 10) = trophy;
        
        % Show "BADGE EARNED" text
        badgeText = textToSprites('BADGE EARNED!');
        progressImage(12, 4:(3+length(badgeText))) = badgeText;
    else
        % Displays encouragement to make users feel good
        progressImage(11, 10) = smile;
        noBadgeText = textToSprites('KEEP GOING!');
        progressImage(12, 5:(4+length(noBadgeText))) = noBadgeText;
    end
    
    % Back Button:
    backSprites = textToSprites('BACK');
    progressImage(14, 1:4) = backSprites;
    
    % Display:
    drawScene(gameScene, progressImage);
    title('Your Progress Statistics');
    
    % Print detailed statistics to command window (Keep this for backup)
    fprintf('Your Progress: \n');
    fprintf('Countries Explored: %d/51\n', completedCount);
    fprintf('Current Rank: %s\n', rankTitle);
    fprintf('Click anywhere to return to main menu.\n');
    
    % Wait for user to click
    getMouseInput(gameScene);
end

function sprites = textToSprites(text)
    % Converts a text string to corresponding sprite IDs for display.
    % Letters are mapped to their sprite sheet positions
    % Spaces are converted to empty sprites.
    %
    % Input:
    %   text - String to convert
    %
    % Output:
    %   sprites - Array of sprite IDs
    
    % Correct sprite mapping for letters
    % A-M: 980-992, N-Z: 1012-1024
    letterMap = [980, 981, 982, 983, 984, 985, 986, 987, 988, 989, 990, 991, 992, ...
                 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024];
    
    % Numbers 0-9: sprites 948-957
    numberMap = [948, 949, 950, 951, 952, 953, 954, 955, 956, 957];
    
    text = upper(text);
    sprites = [];
    
    for i = 1:length(text)
        char = text(i);
        if char >= 'A' && char <= 'Z'
            % Get position in alphabet (A=1, B=2, ..., Z=26)
            letterIndex = char - 'A' + 1;
            % Look up correct sprite ID from map
            spriteID = letterMap(letterIndex);
            sprites = [sprites, spriteID];
        elseif char >= '0' && char <= '9'
            % Get number position (0=1, 1=2, ..., 9=10)
            numIndex = char - '0' + 1;
            spriteID = numberMap(numIndex);
            sprites = [sprites, spriteID];
        elseif char == ' '
            % Use empty sprite for spaces
            sprites = [sprites, 1];
        elseif char == '.'
            %sprite for periods
            sprites = [sprites, 959];
        elseif char == '/'
            %sprite for slashes (no slash on sprite sheet so using a sword)
            sprites = [sprites, 770];
        elseif char == '%'
            %sprite for percentage sign
            sprites = [sprites, 960];
        elseif char == ':'
            %sprite for colon
            sprites = [sprites, 958];
        else
            % For other characters (punctuation) use empty sprite
            sprites = [sprites, 1];
        end
    end
end