% Name:      Mustafa Elshikh, Ava Price
% Date:      December 2024
% Course:    ENGR 1181
% Project:   Geography Explorer
% File:      buildCountryColorMap.m
% Purpose:   Builds a mapping between mask colors and country indices
%            by detecting unique colors in the europe_mask.png file

function [colorMap, maskImage] = buildCountryColorMap()
    % This function loads the mapping between mask colors
    % and country indices. The mapping is created using setupCountryMapping.
    % colorMap - Nx4 matrix where each row is [R, G, B, countryIndex]
    % maskImage - The loaded mask image to find pixels
    % Load the color mask image
    if ~isfile('europe_mask.png')
        error('Error: europe_mask.png not found.');
    end
    
    maskImage = imread('europe_mask.png');
    maskImage = uint8(maskImage(:, :, 1:3));
    
    % Load the pre-created mapping file
    if ~isfile('countryMapping.mat')
        error(['Error: countryMapping.mat not found.\n' ...
               'You need to run setupCountryMapping first to create mapping.\n' ...
               'Type: setupCountryMapping in the command window.']);
    end
    
    mapping = load('countryMapping.mat');
    colorMap = mapping.colorMap;
    
    fprintf('Loaded country mapping with %d regions.\n', size(colorMap, 1));
    
    % Show sample mappings
    validMappings = colorMap(colorMap(:,4) > 0, :);
    fprintf('Found %d mapped countries.\n', size(validMappings, 1));
end
