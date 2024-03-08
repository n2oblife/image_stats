function bad_pxls = mapping_bad_pxls(img_mtx)
    # 
    # Usage: bad_pxls = mapping_bad_pxls(img_mtx)
    #   mapps the bad pixels of an image based on its statistic deficiency
    #
    # Parameters :
    #   img_mtx (array of arrays) : the image matrix
    # 
    # Returns :
    #   bad_pxls (array) : the bad pixels coordinates of the image
    #
    [h,w] = size(img_mtx);
    worst_bad_pxls = zeros(1, h*w);
    last_elt = 1

    stats = stats_img(img_mtx);

    % acceptability zones
    mean_accatpable = [stats(1)-stats(3), stats(1)+stats(3)];
    med_accatpable = [stats(2)-stats(4), stats(2)+stats(4)];
    
    for i=1:h
        for j=1:w
        % should check if we want union or intersection with mean and median
            if ( img_mtx(i,j) < mean_accatpable(1) || img_mtx(i,j) > mean_accatpable(2) ) ||  (img_mtx(i,j) < med_accatpable(1) || img_mtx(i,j) > med_accatpable(2) )
                bad_pxls(last_elt) = [i,j];
                last_elt = last_elt + 1;
            endif
        endfor
    endfor
    % remove empty elements from worst case
    bad_pxls = worst_bad_pxls(1:last_elt-1);
endfunction
