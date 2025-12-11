% Name:      Mustafa Elshikh, Ava Price
% Date:      December 2024
% Course:    ENGR 1181
% Project:   Geography Explorer
% File:      displayCountryInfo.m
% Purpose:   Displays multiscreen infographic with country information
%            including history, culture, and fun facts

function navChoice = displayCountryInfo(gameScene, countryData, countryIndex)
    % This function shows a series of informational screens about a selected
    % country, displaying details like capital, population, history, culture,
    % and fun facts using sprite-based graphics as to implement SGE.
    %
    % Input:
    %   gameScene - SGE scene object
    %   countryData - Structure array with all country information
    %   countryIndex - Integer (1-51) indicating which country
    %
    % Output:
    %   navChoice - Integer (1=Continue, 2=Return to Map, 3=Main Menu)
    
    % Get the data for this specific country
    country = countryData(countryIndex);
    
    % Show basic overview (capital, population, size, region)
    displayBasicInfo(gameScene, country);
    fprintf('\nDisplaying information for: %s\n', country.Country);
    
    % Show historical background
    displayHistoryScreen(gameScene, country);
    
    % Show cultural highlights (food, landmarks, music)
    displayCulturalScreen(gameScene, country);
    
    % Show interesting fun fact
    displayFunFactScreen(gameScene, country);
    
    % Ask user where they want to go next
    navChoice = displayNavigationScreen(gameScene);
end

function displayBasicInfo(gameScene, country)
    % Displays the basic overview screen with key country statistics
    
    % Create bordered frame for infographic display
    infoImage = createInfoFrame();
    
    % Convert country name to sprite IDs and center it
    nameSprites = textToSprites(country.Country);
    startCol = max(3, 11 - floor(length(nameSprites)/2));
    endCol = startCol + length(nameSprites) - 1;
    if endCol <= 18
        infoImage(2, startCol:endCol) = nameSprites;
    end
    
    % Capital Section:
    labelSprites = textToSprites('CAPITAL');
    infoImage(5, 3:9) = labelSprites;
    % Display actual capital city (max 16 chars per line)
    capitalSprites = textToSprites(country.Capital);
    if length(capitalSprites) <= 16
        infoImage(6, 3:(2+length(capitalSprites))) = capitalSprites;
    else
        % If too long, show first 16 chars on line 1, rest on line 2
        infoImage(6, 3:18) = capitalSprites(1:16);
        if length(capitalSprites) > 16
            remaining = min(16, length(capitalSprites) - 16);
            infoImage(7, 3:(2+remaining)) = capitalSprites(17:16+remaining);
        end
    end
    
    % Population Section:
    popSprites = textToSprites('POPULATION');
    infoImage(8, 3:12) = popSprites;
    try
        if iscell(country.Population)
            popStr = country.Population{1};
        else
            popStr = country.Population;
        end
        
        if ischar(popStr) || isstring(popStr)
            popValue = str2double(popStr);
        else
            popValue = popStr;
        end
        
        if isnan(popValue)
            popText = char(popStr); 
        elseif popValue > 0
            if popValue > 1000000
                popText = sprintf('%.1fM', popValue / 1000000);
            elseif popValue > 1000
                 popText = sprintf('%.0fk', popValue / 1000);
            else
                popText = sprintf('%d', round(popValue));
            end
        else
            popText = 'N/A';
        end
        
        popDataSprites = textToSprites(popText);
        if length(popDataSprites) <= 16
            infoImage(9, 3:(2+length(popDataSprites))) = popDataSprites;
        end
    catch
        infoImage(9, 3:5) = textToSprites('SEE');
        infoImage(9, 7:11) = textToSprites('BELOW');
    end
    
    % Land Size Section:
    landSprites = textToSprites('LAND SIZE');
    infoImage(11, 3:11) = landSprites;
    if isnumeric(country.LandSize)
        landValue = country.LandSize;
    else
        landValue = str2double(country.LandSize);
    end
    if ~isnan(landValue) && landValue > 0
        landText = sprintf('%dK SQ KM', round(landValue / 1000));
        landDataSprites = textToSprites(landText);
        if length(landDataSprites) <= 16
            infoImage(12, 3:(2+length(landDataSprites))) = landDataSprites;
        else
            landText = sprintf('%dK', round(landValue / 1000));
            landDataSprites = textToSprites(landText);
            if length(landDataSprites) <= 16
                infoImage(12, 3:(2+length(landDataSprites))) = landDataSprites;
            end
        end
    end
    
    % Region Section:
    regionSprites = textToSprites('REGION');
    infoImage(14, 3:8) = regionSprites;
    
    % Gets Text and Splits
    fullText = country.Region;
    words = strsplit(fullText, ' ');
    
    % Settings
    maxCharsPerLine = 16;
    startRow = 15;
    
    % This checks how tall the board is and sets the limit
    % to the second-to-last row (leaving 1 row of padding at the bottom).
    maxRow = size(infoImage, 1) - 1; 
    
    currentLine = '';
    currentRow = startRow;
    
    % 3. Loop through words
    for i = 1:length(words)
        nextWord = words{i};
        
        if length(currentLine) + length(nextWord) + 1 > maxCharsPerLine
            % Print current line
            if currentRow <= maxRow
                lineSprites = textToSprites(strtrim(currentLine));
                infoImage(currentRow, 3:(2+length(lineSprites))) = lineSprites;
            end
            % Move to next row
            currentRow = currentRow + 1;
            currentLine = nextWord;
        else
            % Add to current line
            if isempty(currentLine)
                currentLine = nextWord;
            else
                currentLine = [currentLine ' ' nextWord];
            end
        end
    end
    
    % Print Remainder if there is space (should be for all current cases)
    if ~isempty(currentLine) && currentRow <= maxRow
        lineSprites = textToSprites(strtrim(currentLine));
        infoImage(currentRow, 3:(2+length(lineSprites))) = lineSprites;
    end

    
    drawScene(gameScene, infoImage);
    title(sprintf('%s - Basic Information', country.Country));
    
    % Print details to command window and wait for user to continue
    fprintf('Capital: %s\n', country.Capital);
    fprintf('Population: %s\n', country.Population);
    fprintf('Land Size: %s sq km\n', country.LandSize);
    fprintf('Region: %s\n', country.Region);
    fprintf('Click anywhere to continue...\n');
    getMouseInput(gameScene);
end

function displayHistoryScreen(gameScene, country)
    % Displays the historical background screen
    
    infoImage = createInfoFrame();
    
    % Add "HISTORY" title
    histSprites = textToSprites('HISTORY');
    infoImage(2, 3:9) = histSprites;
    
    % Logic for word wrapping:
    
    % 1. Get the full text
    fullText = country.History;
    
    % 2. Split the text into individual words
    words = strsplit(fullText, ' ');
    
    % 3. Settings for the display
    maxCharsPerLine = 16; 
    startRow = 5;         % Starts printing on this row
    maxRow = 12;          % Doesn't print below this row (avoids crashing)
    currentLine = '';     % Buffers to hold the line we are building
    currentRow = startRow;
    
    % 4. Loop through every word
    for i = 1:length(words)
        nextWord = words{i};
        
        % Checks if adding the next word exceeds the limit...
        if length(currentLine) + length(nextWord) + 1 > maxCharsPerLine
            % Prints the current line to the screen
            if currentRow <= maxRow
                lineSprites = textToSprites(strtrim(currentLine));
                % Center the text or left align? (Left align logic below)
                infoImage(currentRow, 3:(2+length(lineSprites))) = lineSprites;
            end
            
            % Move to the next row
            currentRow = currentRow + 1;
            
            % Start the NEW line with the current word
            currentLine = nextWord; 
        else
            % If it fits, just append the word to the current line
            if isempty(currentLine)
                currentLine = nextWord;
            else
                currentLine = [currentLine ' ' nextWord];
            end
        end
    end
    
    % Print the very last line remaining in the buffer
    if ~isempty(currentLine) && currentRow <= maxRow
        lineSprites = textToSprites(strtrim(currentLine));
        infoImage(currentRow, 3:(2+length(lineSprites))) = lineSprites;
    end
    
    % Word Wrapping Logic Ends here
    
    drawScene(gameScene, infoImage);
    title(sprintf('%s - Historical Background', country.Country));
    
    % Print to command window for backup reading and checking that data is
    % correct
    fprintf('\nBrief History:\n%s\n', country.History);
    fprintf('Click to continue...\n');
    getMouseInput(gameScene);
end

function displayCulturalScreen(gameScene, country)
    % Displays the cultural information screen
    
    infoImage = createInfoFrame();
    
    % Add "CULTURE" title
    cultSprites = textToSprites('CULTURE');
    infoImage(2, 3:9) = cultSprites;
    
    % Add sections for different cultural aspects with actual data (truncated to fit)
    foodSprites = textToSprites('FOOD');
    infoImage(5, 3:6) = foodSprites;
    % Display food (max 16 chars)
    foodData = textToSprites(country.Food);
    foodLen = min(16, length(foodData));
    if foodLen > 0
        infoImage(6, 3:(2+foodLen)) = foodData(1:foodLen);
    end
    
    landmarkSprites = textToSprites('LANDMARK');
    infoImage(9, 3:10) = landmarkSprites;
    % Display landmark (max 16 chars)
    landmarkData = textToSprites(country.Landmark);
    landLen = min(16, length(landmarkData));
    if landLen > 0
        infoImage(10, 3:(2+landLen)) = landmarkData(1:landLen);
    end
    
    musicSprites = textToSprites('MUSIC');
    infoImage(13, 3:7) = musicSprites;
    % Display music (max 16 chars)
    musicData = textToSprites(country.Music);
    musicLen = min(16, length(musicData));
    if musicLen > 0
        infoImage(14, 3:(2+musicLen)) = musicData(1:musicLen);
    end
    
    drawScene(gameScene, infoImage);
    title(sprintf('%s - Cultural Highlights', country.Country));
    
    %print to command window
    fprintf('\nTraditional Food: %s\n', country.Food);
    fprintf('Famous Landmark: %s\n', country.Landmark);
    fprintf('Music Culture: %s\n', country.Music);
    fprintf('Click to continue...\n');
    getMouseInput(gameScene);
end

function displayFunFactScreen(gameScene, country)
    % Displays the fun fact screen with smart word wrapping
    
    infoImage = createInfoFrame();
    
    % Add "FUN FACT" title with smiley emoji (Sprite 852)
    funSprites = textToSprites('FUN FACT');
    infoImage(2, 3:10) = funSprites;
    infoImage(2, 12) = 852; 
    
    % Smart word wrapping logic again (could maybe implement a method for
    % this in the future)
    
    % 1. Get the full text
    fullText = country.FunFact;
    
    % 2. Split into words to prevent cutting words in middle
    words = strsplit(fullText, ' ');
    
    % 3. Display Settings
    maxCharsPerLine = 16; 
    startRow = 5;         
    maxRow = 12;          % Stop printing at this row to avoid crashes
    
    currentLine = '';     
    currentRow = startRow;
    
    % 4. Loop through every word
    for i = 1:length(words)
        nextWord = words{i};
        
        % Check if adding the next word exceeds the line limit
        if length(currentLine) + length(nextWord) + 1 > maxCharsPerLine
            % A. Print the current line
            if currentRow <= maxRow
                lineSprites = textToSprites(strtrim(currentLine));
                infoImage(currentRow, 3:(2+length(lineSprites))) = lineSprites;
            end
            
            % B. Move to next row
            currentRow = currentRow + 1;
            
            % C. Start new line with the pending word
            currentLine = nextWord;
        else
            % Append word to current line
            if isempty(currentLine)
                currentLine = nextWord;
            else
                currentLine = [currentLine ' ' nextWord];
            end
        end
    end
    
    % 5. Print any remaining text in the buffer
    if ~isempty(currentLine) && currentRow <= maxRow
        lineSprites = textToSprites(strtrim(currentLine));
        infoImage(currentRow, 3:(2+length(lineSprites))) = lineSprites;
    end
    
    % Display Update:
    
    drawScene(gameScene, infoImage);
    title(sprintf('%s - Fun Fact!', country.Country));
    
    fprintf('\nFun Fact:\n%s\n', country.FunFact);
    fprintf('Click to continue...\n');
    getMouseInput(gameScene);
end

function navChoice = displayNavigationScreen(gameScene)
    % Displays navigation options and gets user's next action
    
    infoImage = createInfoFrame();
    
    % Add menu options
    contSprites = textToSprites('CONTINUE');
    infoImage(5, 3:10) = contSprites;
    
    menuSprites = textToSprites('MENU');
    infoImage(15, 3:6) = menuSprites;
    
    drawScene(gameScene, infoImage);
    title('What would you like to do next?');
    
    % Keep asking until valid choice is made
    validChoice = 0;
    while validChoice == 0
        [row, ~, ~] = getMouseInput(gameScene);
        
        if row >= 4 && row <= 7
            navChoice = 1;
            validChoice = 1;
        elseif row >= 8 && row <= 12
            navChoice = 2;
            validChoice = 1;
        elseif row >= 13 && row <= 17
            navChoice = 3;
            validChoice = 1;
        else
            fprintf('Invalid selection. Please try again.\n');
        end
    end
end

function frame = createInfoFrame()
    % Creates a 20x20 bordered frame for infographic display using sprites
    
    % Define border sprite IDs from sprite sheet
    tl = 625; tm = 626; tr = 627;
    lm = 657; rm = 659;
    bl = 689; bm = 690; br = 691;
    empty = 1;
    
    frame = ones(20);
    
    % Create top border
    frame(1, 2:19) = [tl, repmat(tm, 1, 16), tr];
    
    % Create middle rows with left and right borders
    for row = 2:19
        frame(row, 2:19) = [lm, repmat(empty, 1, 16), rm];
    end
    
    % Create bottom border
    frame(20, 2:19) = [bl, repmat(bm, 1, 16), br];
end

%the following function was implemented in a number of methods and could
%itself have become its own method
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
        elseif char == ':'
            %sprite for colon
            sprites = [sprites, 958];
        else
            % For other characters (punctuation) use empty sprite
            sprites = [sprites, 1];
        end
    end
end