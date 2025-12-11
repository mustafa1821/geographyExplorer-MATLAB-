% Name:      Mustafa Elshikh, Ava Price
% Date:      December 2024
% Course:    ENGR 1181
% Project:   Geography Explorer
% File:      loadCountryData.m
% Purpose:   (ABOVE ALL ELSE THIS IS FOR THE DATA AND ANALYTICS
%              IINTEGRATION BONUS POINTS.)
%            Reads the Excel file containing all country information and
%            converts it into an organized MATLAB structure array

function countryData = loadCountryData(filename)
    % This function loads country data from an Excel spreadsheet and
    % converts it into a MATLAB structure array where each element
    % represents one country with all its information fields.
    %
    % Input:
    %   filename - String containing Excel filename (e.g., 'gameData.xlsx')
    %
    % Output:
    %   countryData - Structure array with 51 elements, each containing
    %                 10 fields (Country, Capital, Population, etc.)
    
    % Check if the Excel file exists in current directory
    if ~isfile(filename)
        error('Error: File "%s" not found. Please verify the file is in the current directory.', filename);
    end
    
    % Read data from Excel into a table
    try
        dataTable = readtable(filename, 'Sheet', 'Europe Countries');
    catch ME
        error('Error reading Excel file: %s', ME.message);
    end
    
    % Verify we have the expected number of countries
    numCountries = height(dataTable);
    if numCountries ~= 51
        warning('Expected 51 countries, but found %d in the file.', numCountries);
    end
    
    % Convert table to structure array for easier access
    countryData = struct();
    
    for i = 1:numCountries
        countryData(i).Country = dataTable.Country{i};
        countryData(i).Capital = dataTable.Capital{i};
        countryData(i).Population = dataTable.Population{i};
        countryData(i).LandSize = dataTable.Land_Size_sq_km{i};
        countryData(i).Region = dataTable.Region{i};
        countryData(i).History = dataTable.Brief_History{i};
        countryData(i).Food = dataTable.Traditional_Food{i};
        countryData(i).Landmark = dataTable.Famous_Landmark{i};
        countryData(i).Music = dataTable.Music_Culture{i};
        countryData(i).FunFact = dataTable.Fun_Fact{i};
    end
    
    fprintf('Data loaded: %d countries with complete information.\n', numCountries);
end
