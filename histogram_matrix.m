function histo = histogram_matrix(img_mtx, depth=14)
    #
    # Usage : histogram_matrix(img_mtx, depth)
    #   Computes the histogram of a matrix image according to depth of pixels
    # 
    # Parameters :
    #   img_mtx (array of arrays) : the image matrix to compute
    #   depth (int) : depth of the pixels, default = 14
    #
    # Returns :
    #   histo (array) : histogram of the matrix with 2^depth bins 
    [h,w] = size(img_mtx);
    histo = zeros(1,2^depth);
    printf("Computing global histogram ...\n");
    for i=1:h
        for j=1:w
            px_value = img_mtx(i,j); % dans le code de R sanchez, ajout de 2^14 / 2 ? Ne semble pas nécessaire
            histo(px_value +1 ) += + 1; % shift à cause de l'indexation de matlab
        endfor
    endfor
endfunction