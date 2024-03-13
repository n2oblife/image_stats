function histo = histogram_mtx(img_mtx, depth=14)
    #
    # Usage : histogram_mtx(img_mtx, depth)
    #   Computes the histogram of a matrix image according to depth of pixels
    # 
    # Parameters :
    #   img_mtx (array of arrays) : the image matrix to compute
    #   depth (int) : depth of the pixels
    #
    # Returns :
    #   histo (array) : histogram of the matrix 
    [h,w] = size(img_mtx);
    histo = zeros(1,2^depth);
    for i=1:h
        for j=1:w
            px_value = img_mtx(i,j); % dans le code de R sanchez, ajout de 2^14 / 2 ? Ne semble pas nécessaire
            histo(px_value +1 ) += + 1;
        endfor
    endfor
endfunction