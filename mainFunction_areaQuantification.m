%script main_function_area
% Fix import filename issue. Need the filenames to come from the
% filenames themselves, not as user input
%% Inputs for user
%replace "Pictures" with where your folder containing the pictures is
location = '~/Documents/Work for Scott/Image_processing/Pictures/';

%name the excel file where the areas are stored
name_of_excel_file = 'test4';

%filenames of each file
filenames = {'File1','File2'};

%% Code stuff
% 
% dir_struct = dir('Pictures/*.jpg');
% 
% filenames = [];
% 
% for i = 1:length(dir_struct.name)
% 
%     filenames = [filenames,dir_struct.name];
% end

%read the images into a datastore
ds = imageDatastore(location,'Labels',filenames);

%read the images into a cell
I_list = readall(ds);

%read the images into a structure
I_struct = cell2struct(I_list,filenames);

%run the code on the images. BW_out_array is the BW images, Area_array is a
%cell of the areas of each file. 
[BW_out_array,Area_array] = multiple_fR(I_struct,name_of_excel_file);

%if you want to see a BW picture, type imshow(BW_out_array.name_of_file) in
%the command window. If you want to see a list of specific areas, type
%Area_array.name_of_file in the command window
