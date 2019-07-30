function [names,BW_out_array,Area_array,Average_area] = multiple_fR(structure_of_images,name_of_excel_file)
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
    
writecell(names',name_of_excel_file,'FileType','Spreadsheet','Range',[char(65) '1:' char(65 + floor(length(names)/26)) char(64+length(names) - floor(length(names)/26)*26) '1']); 

% Write all black and white pictures to a folder BWpictures
for image = 1:length(names)
    
    imwrite(BW_out_array.(names{image}),['../BWpictures/' names{image} '.png'])

end

end