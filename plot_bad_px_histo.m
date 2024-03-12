function plot_bad_px_histo(filepath, value, h=480, w=640)
    img_mtx = read_img_file(filepath, h, w);

    list_position = get_position(img_mtx, value);
    [~, len] = size(list_position);

    for id=1:len
        [x,y] = list_position(id);
        sorted_ker = local_median(img_mtx, x, y);
        stats = stats_vct(vector)
    endfor

endfunction

function list_bad_px = get_position(img_mtx, value)
    #
    # Usage : get_position(img_mtx, value)
    #   Get the position of the bad pixels in the image
    #
    # Parameters :
    #   img_mtx (array of arrays) : the image matrix to compute
    #   value (int) : the value to compare to
    #
    # Returns :
    #   list_bad_px (matrix) : an array with the coordinates of th bad pixels
    list_bad_px = cell;
    for i = 1:size(img_mtx, 1)
        for j = 1:size(img_mtx, 2)
            if img_mtx(i, j) >= value
                fprintf('Bad pixel at (%d, %d)\n', i, j);
                list_bad_px(end+1) = [i,j];
            end
        end
    end
endfunction

function sorted_kernel = local_median(img_mtx, x, y, kernel_size=3)
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
    sorted_kernel = sort_kernel(kernel_buffer)
    % we choose randomly between floor and ceil function to minimize bias when choosing mediane
    random_picking = [floor(len/2), ceil(len/2)]( randi(2) );
    kernel_med = sorted_kernel(random_picking)
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
    stats = zeros(1,5);
    stats(1) = mean(vector);
    stats(2) = median(vector);
    stats(3) = var(vector);
    stats(4) = std(vector); % standard deviation
    stats(5) = mad(vector); % mean absolute deviation
endfunction