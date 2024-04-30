function histo = histogram_vector(vector, depth=8)
    #
    # Usage : histogram_vector(vector, depth)
    #   Computes the histogram of a vector according to depth of pixels
    # 
    # Parameters :
    #   vector (array of arrays) : the vector to compute
    #   depth (int) : depth of the pixels, default = 14
    #
    # Returns :
    #   histo (array) : histogram of the vector with 2^depth bins 
    histo = zeros(1,2^depth);
    printf("Computing histogram ...\n");
    for idx=1:length(vector)
            px_value = round(vector(idx));
            histo(px_value +1 ) += 1; % shift à cause de l'indexation de matlab
    endfor
endfunction