function buffer = buff_switching(img_mtx, x, y, kernel_size = 3)
    # 
    # Usage : buff_switching(img_mtx, x, y, kernel_size)
    #   Switch elements of the buffer along with the movement of the kernel
    #
    # Paramters:
    #   img_mtx (array of arrays) : matrix image
    #   x (int) : coordinate x in the image
    #   y (int) : coordinate y in the image
    #   kernel_size (int) : size of the kernel, default = 3
    #
    # Returns :
    #   buffer (array) : array of values of the kernel around (x,y)
    #
    buffer = zeros(1,kernel_size^2);
    border = floor(kernel_size/2);
    for k=1:kernel_size
        for m=1:kernel_size
            % save the elements of the kernel in a buffer for comparison and simulating
            buffer((k-1)*kernel_size+m) = img_mtx(x + (k-1) - border, y + (m-1) - border);
        endfor
    endfor
endfunction