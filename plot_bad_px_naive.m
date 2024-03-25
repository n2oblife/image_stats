function plot_bad_px_naive(filepath, value, h=480, w=640)
    % no use
    img_mtx = read_img_file(filepath, h, w);

    list_position = get_position(img_mtx, value);
    [~, len] = size(list_position);

    for id=1:len
        % to get the element of the cell, need to have brackets
        pos = list_position(id){1};
        printf("Infos of the pixel at (%d, %d) \n", pos(1), pos(2));
        sorted_ker = local_median(img_mtx, pos(1), pos(2));
        stats = stats_vct(sorted_ker)
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
                % in imageJ lists start at 0 !
                % fprintf('Bad pixel at (%d, %d)\n', i, j);
                list_bad_px(end+1) = [i,j];
            end
        end
    end
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