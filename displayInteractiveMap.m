% Name:      Mustafa Elshikh, Ava Price
% Date:      December 2024
% Course:    ENGR 1181
% Project:   Geography Explorer
% File:      displayInteractiveMap.m
% Purpose:   Shows the Europe map with clickable countries using color mask
%            detection for accurate country identification

function selectedCountry = displayInteractiveMap(visitedCountries)
    % This function displays an interactive map of Europe where users can
    % click on countries to learn about them. It uses a color mask system
    % where each country is assigned a unique RGB color for pixel-perfect
    % detection when the user clicks.
    %
    % Input:
    %   visitedCountries - 51-element logical array (true = visited, false = not visited)
    %
    % Output:
    %   selectedCountry - Integer index (1-51) or 0 to return to menu
    
    % Load the display map image (outline style, clean for viewing)
    try
        mapImage = imread('europe_map.png');
    catch
        error('Error: Could not load europe_map.png. Make sure it is in the current directory.');
    end
    
    % Load the color mask image (each country has unique RGB color)
    try
        maskImage = imread('europe_mask.png');
        maskImage = uint8(maskImage(:, :, 1:3));
    catch
        error('Error: Could not load europe_mask.png. Make sure it is in the current directory.');
    end
    
    % Build the mapping between RGB colors and country indices (links each
    % color region number to the proper ccorresponding country number from
    % the data sheet.
    [colorMap, ~] = buildCountryColorMap();
    
    % Create figure window
    screenSize = get(0, 'ScreenSize');
    mapFig = figure('Name', 'Geography Explorer - Map of Europe', ...
                    'NumberTitle', 'off', ...
                    'Position', [50, 50, screenSize(3)-100, screenSize(4)-150]);
    
    % Display map
    imshow(mapImage);
    title('Click on a country to learn about it!', 'FontSize', 16, 'FontWeight', 'bold');
    
    % Add instruction text and progress number in top right corner
    text(1150, 80, 'Click on any country', 'Color', 'black', 'FontSize', 12, ...
         'FontWeight', 'bold', 'BackgroundColor', 'white', 'EdgeColor', 'black', 'Margin', 3);
    text(1190, 160, sprintf('Explored: %d/51', sum(visitedCountries)), 'Color', 'black', ...
         'FontSize', 12, 'FontWeight', 'bold', 'BackgroundColor', 'white', 'EdgeColor', 'black', 'Margin', 3);
    
    % Add return button in bottom right
    text(1400, 1480, 'Main Menu', 'Color', 'white', 'FontSize', 10, ...
         'FontWeight', 'bold', 'BackgroundColor', 'red', 'EdgeColor', 'black', 'Margin', 3);
    
    % Input validation loop - keep asking for clicks until valid selection
    validSelection = 0;
    
    while validSelection == 0
        % Get mouse click coordinates using MATLAB's ginput function
        % (couldnt use SGE for this method in order to be able to use the
        % masked map and europe maps)
        [x, y] = ginput(1);
        
        % Round to integer pixel coordinates
        x = round(x);
        y = round(y);
        
        % Check if user clicked the back button (bottom right area)
        if y > 1450 && x > 1350
            selectedCountry = 0;
            validSelection = 1;
            fprintf('Returning to main menu...\n');
            close(mapFig);
            return;
        end
        
        % Make sure click is within image bounds
        [h, w, ~] = size(maskImage);
        if x < 1 || y < 1 || x > w || y > h
            fprintf('Click is outside the map. Please try again.\n');
            continue;
        end
        
        % Read the RGB color at the clicked position in the mask
        clickedColor = double(squeeze(maskImage(y, x, :)))';
        
        % Check if clicked on white background (sea or border)
        if all(clickedColor == [255, 255, 255])
            fprintf('You clicked on the sea or border. Please click on a country.\n');
            continue;
        end
        
        % Find which country matches the color clicked on
        foundCountry = 0;
        for i = 1:size(colorMap, 1)
            if all(colorMap(i, 1:3) == clickedColor)
                selectedCountry = colorMap(i, 4);
                validSelection = 1;
                foundCountry = 1;
                fprintf('Country selected: #%d\n', selectedCountry);
                break;
            end
        end
        
        % If color not found in our mapping, ask to try again
        if ~foundCountry
            fprintf('Country not recognized. Please try clicking again.\n');
        end
    end
    
    close(mapFig);
end