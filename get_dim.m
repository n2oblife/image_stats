function [h_, w_] = get_dim(filename)
    #
    # Usage : get_dim(filename)
    #   Returns the dimensions of the image from its filename.
    #   Expected format : '<other>_w<width>_h<height>_<other>'
    #
    # Parameters :
    #   filename (string) : the name of the file
    #
    # Returns :
    #   h_ (int) : the height of the image
    #   w_ (int) : the width of the image
    #
    % split the filename by '_'
    str_list = strsplit(filename, '_');
    [~,len] = size(str_list);
    for id = 1:len
        stringed = char(str_list(1,id));
        if (stringed(1) == 'w')
            w_ = str2num(substr(stringed, 2));
        elseif (stringed(1) == 'h')
            h_ = str2num(substr(stringed, 2));
        endif
    endfor
endfunction