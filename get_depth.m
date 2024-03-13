function depth = get_depth(filename)
    #
    # Usage : depth = get_depth(filename)
    #   Returns the depth of the image from its filename
    #   Expected format : '<other>_pMono<depth>'
    #
    # Parameters :
    #   filename (string) : the name of the file
    #
    [~,len] = size(filename);
    pMono = filename(len-1:len);
    % TODO add other cases when bits will be different
    if (pMono == '14')
        depth = 14;
    elseif (pMono == 'o8')
        depth = 8; 
    endif
endfunction