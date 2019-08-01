%% This script is for area quantification of H&E stains. The inputs are the 
% location of your pictures and what you want your excel file to be called. 
% The outputs are the black and white images that are actually
% quantified and the excel file with the areas of each image. The function 
% is told to not quantify anything that touches the border of the image, and anything
% that is not within the specified range of pixels, see Parameters section. 
% Note: the pictures need to be in either JPG or PNG format.
% 
% Outputs:
% - Excel file with all areas.
% - BW pictures or BW pictures paired with colored pictures to BWpictures folder. 
% - Violin plot of data (see Plots section).
% - SEM plot of data (see Plots section).
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
% Add the parent folder and subdirectories to path
addpath(genpath('../'))
%% Inputs for user

%Location is where your picture files are. Write the name in quotes.
location = '../Put pictures in here/';

%Name the excel file where the areas are stored. The file will be stored 
%in the folder where the pictures are. Write the name in quotes.
name_of_excel_file = '052019 and 052319 pictures';

%% Parameters

Parameters.QuantRange = [3000,300000]; % Only quantify regions in this pixel range
Parameters.Sensitivity = 0.7; % Sensitivity for imbinarize
Parameters.store_option = 'BW'; % Type 'BW' for just BW pictures, or 'paired' for paired color and BW. 

%% Main function

%load_data_and_clean_filenames loads the data and removes '.jpg' from the
%end of the filename. I_struct contains the BW images and their names. 
I_struct = load_data_and_clean_filenames(location);

%run the code on the images. BW_out_array is the BW images, Area_array is a
%cell of the areas of each file. Also stores paired BW and color images
[names,BW_out_array,Area_array,Average_area] = multiple_fR(I_struct,[location name_of_excel_file ' Processed ' date],Parameters);

%% Plots section. vplot_SEMplot plots both a violinplot and a SEM plot. Replicates is 
% how you want your plots to be organized. Say you have a Control set of
% pictures and a Drug set of pictures. You can define Replicates =
% {'Control','Drug'} and it will plot all the replicates of Control and
% Drug together. You can also define Replicates =
% {'Control1','Control2'...,'Drug1','Drug2'...} and it will plot each
% replicate individually. 
% Example: if the pictures are called mouse3_1.jpg, mouse3_2.jpg, mouse4_1.jpg, mouse4_2.jpg;
% Replicates = {'mouse3','mouse4'}, or 
% Replicates = {'3_1','3_2','4_1','4_2'}, etc.

Replicates = {'Control1','Control2','Control3','Imiquimod1','Imiquimod2','Imiquimod3'};

%Replicates = {'Control','imiquimod'};

[vplot, SEM] = vplot_SEMplot(names,Area_array,Replicates);


