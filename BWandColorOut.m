function BWandColorOut(names,BW_out_array,I_struct,store_option)

if strcmp(store_option,'BW') == 1
    
   for image = 1:length(names)

        imwrite(BW_out_array.(names{image}),['../BWpictures/' names{image} '.png'])
        
        [names{image} ' written to file']
        
   end
else
    for image = 1:length(names)

        pic = imfuse(I_struct.(names{image}),BW_out_array.(names{image}),'montage');

        imwrite(pic,['../BWpictures/' names{image} 'montage.png'])
        
        [names{image} ' paired written to file']

    end

end 

% Write all black and white pictures to a folder BWpictures
