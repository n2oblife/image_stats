function plot_local_histogram(filename, depth=14, acc_fact = 5, kernel_size=3, h=480, w=640)
    #
    # Usage : plot_local_histogram(filename, depth, kernel_size)
    #   Plots the medians of local histograms of an image based on kernel
    #
    # Parameters :
    #   filename (string) : the name of the image file
    #   depth (int) : depth of the pixels, default = 14
    #   acc_fact (int) : acceptability factor for the histogram, default = 5
    #   kernel_size (int) : size of the kernel on which to apply local histogram, default = 3
    #   h (int) : height of the image, number of lines
    #   w (int) : width of the image, number of columns
    #
    % read the file whatver the extension
    img_mtx = read_file(filename, h, w);

    % builds an histogram from local kernels with median extraction
    % saves all values in a vector to compute stats from the median values of local histograms
    [ker_histo, medians_vector] = kernel_histogram(img_mtx, kernel_size, depth);
    stats = stats_vct(medians_vector);

    plotting_stats(ker_histo, stats);
endfunction

function [ker_histo, med_vct] = kernel_histogram(img_mtx, kernel_size=3, depth=14)
    #
    # Usage : kernel_histogram(img_mtx, kernel_size, depth)
    #   Computes the histogram of a little matrix image according to depth of pixels 
    #   by comparing values
    # 
    # Parameters :
    #   img_mtx (array of arrays) : the image matrix to compute
    #   kernel_size (int) : size of the kernel on which to apply local histogram, default = 3
    #   depth (int) : depth of the pixels, default = 14
    #
    # Returns :
    #   histo (array) : histogram of the matrix by kernels
    #
    [h,w] = size(img_mtx);
    border = floor(kernel_size/2);

    ker_histo = zeros(1,2^depth);
    med_vct = zeros(1,(h-2*border)*(w-2*border));

    % for loops on the image with no padding
    for i=1+border:h-border
        for j=1+border:w-border
            % completion status
            completion((h-2*border)*(w-2*border), (i-(1+border))*(w-2*border)+(j-border), "Computing local histogram ");
            kernel_med = local_median(img_mtx, i, j, kernel_size);
            % vector 1:2^depth => shifting of histogram to avoid out of bound
            ker_histo(kernel_med+1) += 1;
            med_vct((i-(1+border))*(w-2*border)+(j-border)) = kernel_med;
        endfor
    endfor
endfunction


function kernel_med = local_median(img_mtx, x, y, kernel_size=3)
    #
    # Usage : local_median(img_mtx, x, y, kernel_size)
    #   Computes the median of a little matrix image according to the size of the kernel 
    #   by sorting the elements and taking middle one
    # 
    # Parameters :
    #   img_mtx (array of arrays) : the image matrix to compute
    #   x (int) : coordinate x in the image
    #   y (int) : coordinate y in the image
    #   kernel_size (int) : size of the kernel on which to apply local histogram, default = 3
    #
    # Returns :
    #   kernel_med (int) : median of the matrix by kernels
    #
    kernel_buffer =  buff_switching(img_mtx, x, y, kernel_size);
    [~, len] = size(kernel_buffer);
    sorted_kernel = sort_kernel(kernel_buffer);
    % we choose randomly between floor and ceil function to minimize bias when choosing mediane
    random_picking = [floor(len/2), ceil(len/2)]( randi(2) );
    kernel_med = sorted_kernel(random_picking);
endfunction


function sorted_vct = sort_kernel(vector)
    #
    # Usage : sort_kernel(vector)
    #   Sorts a vector of elements using insertion sort algorithm
    #
    # Parameter :
    #   vector (array) : a vector to sort
    # 
    # Returns :
    #   sorted_vct (array) : sorted vector of the vector's elements
    #
    [~, len] = size(vector);
    sorted_vct = zeros(1,len);
    sorted_vct(1) = vector(1);
    for rd_head=2:len
        sorted_vct(rd_head) = vector(rd_head);
        for k=rd_head:-1:2
            if ( sorted_vct(k) <= sorted_vct(k-1) );
                % swap the values
                temp = sorted_vct(k-1);
                sorted_vct(k-1) = sorted_vct(k);
                sorted_vct(k) = temp;
            else
                break;
            endif
        endfor
    endfor
endfunction


function stats = stats_vct(vector)
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
    stats = zeros(1,4);
    stats(1) = mean(vector);
    stats(2) = median(vector);
    stats(3) = var(vector);
    stats(4) = std(vector); % standard deviation
endfunction
