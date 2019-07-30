%% This script is for area quantification of H&E stains. The inputs are the 
% location of your pictures and what you want your excel file to be called. 
% The outputs are the black and white images that are actually
% quantified and the excel file with the areas of each image. The function 
% is told to not quantify anything that touches the border of the image, and anything
% that is smaller than 3000 pixels or larger than 300000. 
% Note: the pictures need to be in either
% JPG or PNG format.
% 
% Outputs:
% - Excel file with all areas.
% - BW pictures to BWpictures folder. 
%
% If you want to see which spot corresponds to each area, 
% type imageRegionAnalyzer(BW_out_array.name_of_file). 
% If you want to see the list of areas, type
% Area_array.name_of_file in the command window. 

%{
Ideas for updates:
Threshold BW, maybe just H stain, parameters on excel file
%}
%{ 
Updates:

07/24/19

Fixed a bug that made the program break after processing 26 pictures.

07/25/19

Fixed the bug that came from the bug fix on 07/24/19.

Added a function that saves all the BW pictures to a separate folder,
../BWpictures

%}

%% setup
% clears the workspace
clear all
format compact
% genpath
addpath(genpath('../'))
%% Inputs for user

%Location is where your picture files are. Write the name in quotes.
location = '../Put pictures in here/';

%Name the excel file where the areas are stored. The file will be stored 
%in the folder where the pictures are. Write the name in quotes.
name_of_excel_file = '052319 pictures';

%% Main function

%load_data_and_clean_filenames loads the data and removes '.jpg' from the
%end of the filename. I_struct contains the BW images and their names. 
I_struct = load_data_and_clean_filenames(location);

%run the code on the images. BW_out_array is the BW images, Area_array is a
%cell of the areas of each file. 
[names,BW_out_array,Area_array,Average_area] = multiple_fR(I_struct,[location name_of_excel_file ' Processed ' date]);

