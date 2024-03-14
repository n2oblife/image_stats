function col_vector = get_column(mat, col)
    #
    # Usage : get_column(mat, col)
    #   Get a vector from the columns of the matrix
    #
    # Parameters :
    #   mat (array of array) : the matrix or cell from which to get a specific column
    #   col (int) : number of the column to get
    #
    # Returns :
    #   col_vector (array) : a vector of column values from the matrix
    #
    if (isempty(mat))
        printf('The matrix from which to get the column is empty\n')
        return;
    endif

    % mat_type = typeinfo(mat);
    % TODO add other handling condition
    % if ( strcmp(mat_type,'cell') == 1)
    %     matrix = cell2mat(mat);
    % endif

    [h,w] = size(mat);
    col_vector = zeros(1,h*w);

    for i = 1:h
        for j = 1:w
            col_vector( (i-1)*w + j ) = mat{i,j}(col);
        endfor
    endfor

endfunction