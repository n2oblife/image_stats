function filtered_img = apply_filter(filename, filter_msk, h=480, w=640, show_img=false)
    #
    # Usage : apply_filter(filename, filter_msk, h, w, show_img)
    #   Apply a mask on an image
    #
    # Parameters :
    #   filename (string) : the name of the image file
    #   filter_msk (array) : value of the mask to apply to the image
    #   h (int) : height of the image, number of lines
    #   w (int) : width of the image, number of columns
    #   show_img (bool) : choosing to plot the image
    #
    # Returns :
    #   filtered_img (array of arrays) : image after applying mask
    #
    img_mtx = read_file(filename, h, w);
    filtered_img = compute_mask(img_mtx, filter_msk, show_img);

    if (show_img)
        imshow(filtered_img);
    endif
endfunction


function filtered_img = compute_mask(img_mtx, filter_msk, show_img=false)
    #
    # Usage : compute_mask(img_mtx, filter_msk, show_img)
    #   Apply a mask on a matrix image
    #
    # Parameters :
    #   img_mtx (array of arrays) : matrix image
    #   filter_msk (array) : value of the mask to apply to the image
    #   show_img (bool) : choosing to plot the image
    #
    # Returns : 
    #   filtered_img (array of arrays) : image after applying mask
    #
    % check if the mask is a square
    [kernel_size, k_s] = size(filter_msk);
    if (kernel_size != k_s)
        % TODO return error
        return;
    endif

    [h,w] = size(img_mtx);
    border = floor(kernel_size/2);

    % copy original image to keep the borders
    filtered_img = img_mtx;

    % for loops on the image with no padding
    for i=1+border:h-border
        for j=1+border:w-border
            % completion status
            completion((h-2*border)*(w-2*border), (i-(1+border))*(w-2*border)+(j-border), "Applying mask ");
            filtered_value = local_filter(img_mtx, i, j, filter_msk);
            filtered_img(i,j) = filtered_value;
        endfor
    endfor
endfunction


function value = local_filter(img_mtx, x, y, filter_msk)
    #
    # Usage : local_filter(img_mtx, x, y, filter_msk)
    #   Apply mask on point neighborhood
    #
    # Parameters :
    #   img_mtx (array of arrays) : matrix image
    #   x (int) : coordinate x in the image
    #   y (int) : coordinate y in the image
    #   filter_msk (array) : value of the mask to apply to the image
    #
    # Returns :
    #   value (int) : result of the convolution
    #
    [kernel_size, ~] = size(filter_msk);
    buffer = buff_switching(img_mtx, x, y, kernel_size);
    value = sum(buffer * filter_msk);
endfunction