function mat = cellToMat(cell_)
    # 
    # Usage : cellToMat(cell_)
    #   transforms cells of size [1 x n] with vector elements into a matrix of shape [n x m]
    #
    # Parameters :
    #   cell_ (array of arrays) : cell to transform
    #
    # Returns :
    #   mat (matrix) :  matrix with correct shape
    #
    if (isempty(cell_))
        printf('The cell to transform is empty\n')
        return;
    endif

    [dim, h] = size(cell_);
    if (dim != 1)
        printf('The cell to transform has too many dimensions\n')
        size(cell_)
        return;
    endif

    w = length(cell_{1});
    mat = zeros(h,w);
    for i = 1:h
        for j = 1:w
            mat(i,j) = cell_{i}(j);
        endfor
    endfor
endfunction