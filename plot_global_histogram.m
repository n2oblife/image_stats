function plot_global_histogram(filename, depth = 14, acc_fact = 5)
    #
    # Usage : plot_stats(histo, stats)
    #   Plots the histogram of the image with the mean and standard deviation lines
    #
    # Parameters :
    #   filename (char) : path to the file from which to plot statistics
    #   depth (int) : depth of the pixels, default = 14
    #   acc_fact (int) : acce
    #

    img_mtx = imread(filename);

    histo = histogram_mtx(img_mtx, depth=14)
    stats = stats_img(img_mtx);
    
    plotting_stats(histo, stats, acc_fact);

endfunction


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
    printf("Size of histo %d \n", size(histo)(2));
    for i=1:h
        for j=1:w
            px_value = img_mtx(i,j); % dans le code de R sanchez, ajout de 2^14 / 2 ? Ne semble pas nécessaire
            % printf("value of a pixel : %d \n", px_value);
            histo(px_value +1 ) += + 1;
        endfor
    endfor
endfunction

function img_stats = stats_img(img_mtx)
    #
    # Usage : stats_img(img_mtx)
    #   Compute basic stats from an image
    # 
    # Paramters :
    #   img_mtx (array) : array of pixels from image
    #
    # Returns :
    #   img_stats (array) : array of basic statistics
    #
    img_stats = zeros(1,4);
    img_vct = img_mtx(:);
    img_stats(1) = mean(img_vct);
    img_stats(2) = median(img_vct);
    % img_stats(2) = my_median(img_vct);
    img_stats(3) = var(img_vct);
    img_stats(4) = std(img_vct); % standard deviation
endfunction

function med = my_median(vector)
    [sorted_vct, ~] = sort(vector);
    [~, len] = size(vector);
    med = sorted_vct(ceil(len/2));
endfunction