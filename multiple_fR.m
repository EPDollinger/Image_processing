function [Area_array] = multiple_fR(structure_of_images)

names = fieldnames(structure_of_images);

Area_array = {};

for i = 1:numel(names)
    
    name = names(i);
    
    [~,props] = filterRegions_one(structure_of_images.(names{i}));
    
    Area_array{i} = props.Area;
    
end

writecell(Area_array,'Area counts.xls','FileType','Spreadsheet')

end
