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
% - Violin plot of data, SEM plot of data and some QC plots (see Plots
% section). These plots are saved in BWpictures folder.
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

08/06/19

Added barplots of images per replicate and areas per replicate. Also made
them all subplots.
Added param to ask whether the plots are wanted or not.

%}

%% setup
% clears the workspace
clear all
format compact
% Add the parent folder and subdirectories to path
addpath(genpath('../'))
%% Inputs for user

%Name the excel file where the areas are stored. The file will be stored 
%in the folder where the pictures are. Write the name in quotes.
name_of_excel_file = '052019 and 052319 pictures';

% Replicates is how you want your violin, SEM and QC plots to be organized. 
% Example: if the pictures are called Drug1_picture1.jpg, Drug1_picture2.jpg, 
% Drug2_picture1.jpg, ... Control1_picture1.jpg, Control1_picture2.jpg, Control2_picture1.jpg,...;
% Replicates = {'Drug','Control'} (average and plot only conditions), or 
% Replicates = {'Drug1','Drug2',...,'Control1','Control2',...} (average and plot pictures from each replicate), etc.

%Replicates = {'Imiquimod'};
Replicates = {'Control','Imiquimod'};

%% Parameters

location = '../Put pictures in here/'; %Location is where your picture files are. Write the name in quotes.
Parameters.QuantRange = [3000,300000]; % Only quantify regions in this pixel range
Parameters.Sensitivity = 0.7; % Sensitivity for imbinarize
Parameters.store_option = 'BW'; % Type 'BW' for just BW pictures, or 'paired' for paired color and BW.
Parameters.output_plots = 1; % If you want plots, type 1. If you don't want plots, type 0.

%% Main function

%load_data_and_clean_filenames loads the data and removes '.jpg' from the
%end of the filename. I_struct contains the BW images and their names. 
I_struct = load_data_and_clean_filenames(location);

%run the code on the images. BW_out_array is the BW images, Area_array is a
%cell of the areas of each file. Also stores paired BW and color images
[names,BW_out_array,Area_array,Average_area] = multiple_fR(I_struct,[location name_of_excel_file ' Processed ' date],Parameters);

%Pair color and BW picture and output to file
BWandColorOut(names,BW_out_array,I_struct,Parameters.store_option)

%% Plots section. vplot_SEMplot plots both a violinplot and a SEM plot. 

[fig,bar_images,bar_areas,vplot,SEM] = vplot_SEMplot(names,Area_array,Replicates,Parameters.output_plots);


