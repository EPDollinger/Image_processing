function [BW_out_array,Area_array] = multiple_fR(structure_of_images,name_of_excel_file)
%% This is a function with input a structure of images (several images grouped together) 
%% and output an excel file with list of areas. 

%% Variable setup
Area_array = {}; % setting up variables

BW_out_array = {}; % setting up variables

names = fieldnames(structure_of_images); %The list of names of each picture

%% Actual code. This block runs filterRegions_one on each picture in the group, stores the black and white image that is actually being quantified, and outputs the areas of the white images to the excel file.

for i = 1:numel(names) %iterate over the number of pictures
        
    %store BW image, and properties from running filterRegions_one on each
    %image
    [BW_out_array.(names{i}),props] = filterRegions_one(structure_of_images.(names{i})); 
    
    %store Area specifically from properties
    Area_array.(names{i}) = props.Area;
    
    %Write Area in a column in excel. Each image has its own column and the
    %numbering starts at A.
    writematrix(Area_array.(names{i}),name_of_excel_file,'FileType','Spreadsheet','Range',[char(64+i) '2:' char(64+i) num2str(length(Area_array.(names{i}))+1)]);

    
end

%Write name of each image for each column
writecell(names',name_of_excel_file,'FileType','Spreadsheet','Range',[char(65) '1:' char(64+length(names)) '1']); 

end
