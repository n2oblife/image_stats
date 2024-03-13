function stats = plot_local_histogram(
    filename, depth=14, acc_fact = 5, kernel_size=3, h=480, w=640, steps = 1, show_fig = true
    )
    #
    # Usage : plot_local_histogram(filename, depth, kernel_size)
    #   Plots the medians of local histograms of an image based on kernel
    #
    # Parameters :
    #   filename (string) : path to the file (in unix style) from which to plot statistics
    #   depth (int) : depth of the pixels, default = 14
    #   acc_fact (int) : acceptability factor for the histogram, default = 5
    #   kernel_size (int) : size of the kernel on which to apply local histogram, default = 3
    #   h (int) : height of the image, number of lines
    #   w (int) : width of the image, number of columns
    #   steps (int) : value of the step to avoid to compute everything
    #
    % read the file whatever the extension
    img_mtx = read_img_file(filename, h, w);

    % builds an histogram from local kernels with median extraction
    % saves all values in a vector to compute stats from the median values of local histograms
    [ker_histo, medians_vector] = median_kernel_histogram(
        img_mtx, kernel_size, depth, steps
        );
    stats = stats_vector(medians_vector)

    if (show_fig)
        plotting_stats(ker_histo, stats);
    endif
endfunction

function [ker_histo, med_vct] = median_kernel_histogram(img_mtx, kernel_size=3, depth=14, steps=1)
    #
    # Usage : kernel_histogram(img_mtx, kernel_size, depth)
    #   Computes the histogram of a little matrix image according to depth of pixels 
    #   by comparing values
    # 
    # Parameters :
    #   img_mtx (array of arrays) : the image matrix to compute
    #   kernel_size (int) : size of the kernel on which to apply local histogram, default = 3
    #   depth (int) : depth of the pixels, default = 14
    #   steps (int) : value of the step to avoid to compute everything
    #
    # Returns :
    #   histo (array) : histogram of the matrix by kernels
    #
    [h,w] = size(img_mtx);
    border = floor(kernel_size/2);

    ker_histo = zeros(1,2^depth);
    med_vct = zeros(1,(h-2*border)*(w-2*border));

    % for loops on the image with no padding
    for i=1+border:steps:h-border
        for j=1+border:steps:w-border
            % completion status
            completion((h-2*border)*(w-2*border)/steps, ((i-(1+border))*(w-2*border)+(j-border))/steps , "Computing local histogram ");
            kernel_med = local_median(img_mtx, i, j, kernel_size);
            % vector 1:2^depth => shifting of histogram to avoid out of bound
            ker_histo(kernel_med+1) += 1;
            med_vct((i-(1+border))*(w-2*border)+(j-border)) = kernel_med;
        endfor
    endfor
    fprintf("\n");
endfunction


