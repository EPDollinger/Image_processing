function BWandColorOut(names,BW_out_array,I_struct,Parameters)

if strcmp(Parameters.store_option,'BW') == 1
    
    'Writing BW pictures to folder'
    
   for image = 1:length(names)

        imwrite(BW_out_array.(names{image}),[Parameters.output_location_BWpictures names{image} '.png'])
        
   end
else
    'Writing paired pictures to folder'
    for image = 1:length(names)

        pic = imfuse(I_struct.(names{image}),BW_out_array.(names{image}),'montage');

        imwrite(pic,[Parameters.output_location_BWpictures names{image} 'montage.png'])

    end

end 

% Write all black and white pictures to a folder BWpictures
