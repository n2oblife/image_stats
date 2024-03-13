function sorted_kernel = kernel_values(img_mtx, x, y, kernel_size=3)
    #
    # Usage : kernel_values(img_mtx, x, y, kernel_size)
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
    sorted_kernel = sort_kernel(kernel_buffer);
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