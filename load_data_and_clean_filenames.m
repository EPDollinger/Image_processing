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
