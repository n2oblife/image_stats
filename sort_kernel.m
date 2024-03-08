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