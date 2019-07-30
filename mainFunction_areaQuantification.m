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

07/29/19

Added violin plots
Added SEM plot
Option to output BW pictures or paired BW and color
pictures.
Added Parameters to simplify parameter selection.

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

%Do you want BW pictures stored, or paired BW pictures with colored
%pictures? Type 'BW' for just BW pictures, or 'paired' for paired color and
%BW. 

%% Parameters

Parameters.QuantRange = [10000,300000];
Parameters.Sensitivity = 0.6;
Parameters.store_option = 'paired';

%% Main function

%load_data_and_clean_filenames loads the data and removes '.jpg' from the
%end of the filename. I_struct contains the BW images and their names. 
I_struct = load_data_and_clean_filenames(location);

%run the code on the images. BW_out_array is the BW images, Area_array is a
%cell of the areas of each file. Also stores paired BW and color images
[names,BW_out_array,Area_array,Average_area] = multiple_fR(I_struct,[location name_of_excel_file ' Processed ' date],Parameters);

%% Plots section
Replicates = {'Control1','Control2','Control3','imiquimod1','imiquimod2','imiquimod3'};

%Replicates = {'Control','imiquimod'};

vplot_permouse(names,Area_array,Replicates)


