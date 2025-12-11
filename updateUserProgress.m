% Name:      Mustafa Elshikh, Ava Price
% Date:      December 2024
% Course:    ENGR 1181
% Project:   Geography Explorer
% File:      updateUserProgress.m
% Purpose:   Updates progress tracking arrays, awards passport stamps,
%            checks for regional completion, and updates ranking titles

function [newVisited, newCount, badgeEarned, newRank] = updateUserProgress(countryIdx, visited, count)
    % This function tracks the player's exploration progress by maintaining
    % which countries have been visited, awarding achievements, and updating
    % the player's rank based on total countries explored.
    % Input:
    %   -countryIdx - Integer index of country just visited
    %   -visited - 51-element logical array
    %   -count - Current completed countries count
    % Output:
    %   -newVisited - Updated visited array
    %   -newCount - Updated count
    %   -badgeEarned - badge displayed when recieved
    %   -newRank - String with updated ranking title
    
    % Start with current values
    newVisited = visited;
    newCount = count;
    badgeEarned = 0;
    
    % Check if it's the users first time visiting this country
    if visited(countryIdx) == 0
        fprintf('\nPassport Stamp Earned!\n');
        fprintf('You have explored a new country!\n');
        
        % Mark country as visited and add one to the counter
        newVisited(countryIdx) = 1;
        newCount = count + 1;
        
        fprintf('Total countries explored: %d/51\n', newCount);
        
    else
        % Player is revisiting a country
        fprintf('\nYou have already explored this country.\n');
        fprintf('No new stamp is earned, but you can still review the information!\n');
    end
    
    % Check if player just completed all 51 countries
    if sum(newVisited) == 51
        if count < 51
            fprintf('\nCONGRATULATIONS!\n');
            fprintf('You have explored ALL 51 European countries!\n');
            fprintf('Europe Travel Badge Earned!\n');
            badgeEarned = 1;
        end
    end
    
    % Calculate new rank based on the count of countries explored
    newRank = calculateRanking(newCount);
    
    % Notify player if they've ranked up
    oldRank = calculateRanking(count);
    if ~strcmp(newRank, oldRank)
        fprintf('\nRank Up!\n');
        fprintf('Your new rank: %s\n', newRank);
    end
end

function rankTitle = calculateRanking(completedCount)
    % Determines player rank based on number of countries explored.
    % Ranking system provides the player with motivation to explore more countries.
    % Input:completedCount - Number of countries explored
    % Output:rankTitle - String with ranking title
    
    if completedCount == 0
        rankTitle = 'Level 1 Explorer';
    elseif completedCount <= 10
        rankTitle = 'Level 2 Explorer';
    elseif completedCount <= 20
        rankTitle = 'Level 3 Explorer';
    elseif completedCount <= 35
        rankTitle = 'Level 4 Explorer';
    else
        rankTitle = 'Level 5 Explorer';
    end
end
