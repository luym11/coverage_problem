function important_area_map = important_area_generate_function(M,N,imct_x, imct_y,area_size,decrease_size,Max)

important_area_map = zeros(M,N); 
important_area_map(imct_x, imct_y) = Max; 
important_area_map( (imct_x-area_size) : imct_x, imct_y) = (Max-area_size*decrease_size): decrease_size: Max;
important_area_map( imct_x:(imct_x+area_size), imct_y) = fliplr((Max-area_size*decrease_size): decrease_size: Max);
important_area_map( imct_x, (imct_y-area_size) : imct_y ) = (Max-area_size*decrease_size): decrease_size : Max;
important_area_map( imct_x, imct_y:imct_y+area_size ) = fliplr((Max-area_size*decrease_size): decrease_size: Max);

if(area_size >= 2)
    for i = 2:area_size
        for j = 1:i-1
            important_area_map(imct_x + j, imct_y + i-j) = Max - decrease_size * i;
            important_area_map(imct_x - j, imct_y + i-j) = Max - decrease_size * i;
            important_area_map(imct_x + j, imct_y - (i-j)) = Max - decrease_size * i;
            important_area_map(imct_x - j, imct_y - (i-j)) = Max - decrease_size * i;
        end
    end
end


end

