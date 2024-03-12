function img_mtx = read_img_file(filename, h=480, w=60, show_img=false)
    #
    # Usage : read_img_file(filename, h, w)
    #   Reads any type of file image regardless of the file extension
    # 
    # Parameters :
    #   filename (char) : path to the image file to open
    #   h (int) : height of the image, number of lines
    #   w (int) : width of the image, number of columns
    #   show_img (bool) : choosing to plot the image
    #
    # Returns :
    #   img_mtx (array of arrays) : matrix of the image
    #
    [~,~,extension] = fileparts(filename);
    % TODO add other data type that need to be read differently
    if (extension == '.bin')
        img_mtx = img_bin_to_mtx(filename, h,w);
    else
        img_mtx = imread(filename);
    endif

    if (show_img)
        imshow(img_mtx)
    endif
endfunction