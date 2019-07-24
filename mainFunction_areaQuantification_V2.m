%% This script is for area quantification of H&E stains. The inputs are the 
% location of your pictures and what you want your excel file to be called. 
% The outputs are the black and white images that are actually
% quantified and the excel file with the areas of each image. The function 
% is told to not quantify anything that touches the border of the image, and anything
% that is smaller than 3000 pixels or larger than 300000. 
% Note: the pictures need to be in either
% JPG or PNG format, and there cannot be any spaces in the name of the
% file.
% If you want to see a BW picture, type imshow(BW_out_array.name_of_file) in
% the command window. If you want to see which spot corresponds to each area, 
% type imageRegionAnalyzer(BW_out_array.name_of_file). 
% If you want to see the list of areas, type
% Area_array.name_of_file in the command window. 

%{ 
Updates:

07/24/19

Fixed a bug that made the program break after processing 26 pictures.

%}


% clears the workspace
clear all
format compact
%% Inputs for user

%Location is where your picture files are. Write the name in quotes.
location = '~/Documents/Work for Scott/Pictures/Imiquimod_sections052319/';

%Name the excel file where the areas are stored. The file will be stored 
%in the folder where the pictures are. Write the name in quotes.
name_of_excel_file = '052319 pictures';

%% Main function

%load_data_and_clean_filenames loads the data and removes '.jpg' from the
%end of the filename. I_struct contains the BW images and their names. 
I_struct = load_data_and_clean_filenames(location);

%run the code on the images. BW_out_array is the BW images, Area_array is a
%cell of the areas of each file. 
[BW_out_array,Area_array,Average_area] = multiple_fR(I_struct,[location name_of_excel_file ' Processed ' date]);

%% Supplemental functions

function I_struct = load_data_and_clean_filenames(location)

dir_struct = dir([location '/*.*g']);

%Name the files
filenames = {dir_struct.name};

for filename_number = 1:length(filenames)
    filenames{filename_number} = filenames{filename_number}(1:end-4);
    filenames{filename_number} = strrep(filenames{filename_number},' ','_');
end

%read the images into a datastore
ds = imageDatastore(location,'Labels',filenames);

%read the images into a cell
I_list = readall(ds); 

%read the images into a structure
I_struct = cell2struct(I_list,filenames'); 

end

function [BW_out_array,Area_array,Average_area] = multiple_fR(structure_of_images,name_of_excel_file)
%% This is a function with input a structure of images (several images grouped together) 
%% and output an excel file with list of areas. 

%% Variable setup
Area_array = {}; % setting up variables

BW_out_array = {}; % setting up variables

names = fieldnames(structure_of_images); %The list of names of each picture

Average_area = {};

%% Actual code. This block runs filterRegions_one on each picture in the group, stores the black and white image that is actually being quantified, and outputs the areas of the white images to the excel file.

%How many pictures there are
['There are ' num2str(length(names)) ' pictures']

for i = 1:numel(names) %iterate over the number of pictures
        
    %store BW image, and properties from running filterRegions_one on each
    %image
    [BW_out_array.(names{i}),props] = filterRegions_one(structure_of_images.(names{i})); 
    
    %store Area specifically from properties
    Area_array.(names{i}) = props.Area;
    
    %store Average area of each picture
    Average_area.(names{i}) = mean(Area_array.(names{i}));
    
    if i / 26 < 1 %if the column can start in A
        %Write Area in a column in excel. Each image has its own column and the
        %numbering starts at A.
        writematrix(Area_array.(names{i}),name_of_excel_file,'FileType','Spreadsheet','Range',[char(64+i) '2:' char(64+i) num2str(length(Area_array.(names{i}))+1)]);
        
    elseif i / 26 > 1 %the column starts in AA, AB, AC, etc.
        
        writematrix(Area_array.(names{i}),name_of_excel_file,'FileType','Spreadsheet','Range',[char(64 + floor(i/26)) char(64+i - floor(i/26)*26) '2:' char(64 + floor(i/26)) char(64+i- floor(i/26)*26) num2str(length(Area_array.(names{i}))+1)]);

    end
    %Image counter.
    [num2str(i) ' done']
    
end

%Write name of each image for each column
% namesTable = cell2table(names);
    
writecell(names',name_of_excel_file,'FileType','Spreadsheet','Range',[char(65) '1:' char(64 + floor(length(names)/26)) char(64+length(names) - floor(length(names)/26)*26) '1']); 

end

function [BW_out,properties] = filterRegions_one(BW_in)
%filterRegions  Filter BW image using auto-generated code from imageRegionAnalyzer app.
%  [BW_OUT,PROPERTIES] = filterRegions(BW_IN) filters binary image BW_IN
%  using auto-generated code from the imageRegionAnalyzer app. BW_OUT has
%  had all of the options and filtering selections that were specified in
%  imageRegionAnalyzer applied to it. The PROPERTIES structure contains the
%  attributes of BW_out that were visible in the app.

% Auto-generated by imageRegionAnalyzer app on 21-Jun-2019
%---------------------------------------------------------

BW_out = imcomplement(imbinarize(BW_in(:,:,1)));

% Remove portions of the image that touch an outside edge.
BW_out = imclearborder(BW_out);

% Filter image based on image properties.
BW_out = bwpropfilt(BW_out, 'Area', [3000,300000]);

% Get properties.
properties = regionprops(BW_out, {'Area', 'Eccentricity', 'EquivDiameter', 'EulerNumber', 'MajorAxisLength', 'MinorAxisLength', 'Orientation', 'Perimeter'});

% Sort the properties.
properties = sortProperties(properties, 'Area');

% Uncomment the following line to return the properties in a table.
properties = struct2table(properties);

%writematrix(properties.Area,['Area count'],'FileType', 'spreadsheet')

function properties = sortProperties(properties, sortField)

    % Compute the sort order of the structure based on the sort field.
    [~,idx] = sort([properties.(sortField)], 'descend');

    % Reorder the entire structure.
    properties = properties(idx);
    
end
end