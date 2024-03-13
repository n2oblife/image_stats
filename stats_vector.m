function stats = stats_vector(vector)
    #
    # Usage : stats_vector(vector)
    #   Compute basic stats from an image : 
    #   mean, median, variance, standard deviation, mean absolute deviation
    # 
    # Paramters :
    #   vector (array) : array of values of any size and shape
    #
    # Returns :
    #   stats (array) : array of basic statistics : mean, median, variance, standard deviation, mean absolute deviation
    #
    if (isempty(vector))
        printf('The vector from which to compute stats is empty\n')
        return;
    endif

    stats = zeros(1,5);

    % TODO add other types to handle
    vct_type = typeinfo(vector);
    if ( strcmp(vct_type,'cell') == 1)
        vct = cell2mat(vector);
    else
        vct = vector;
    endif

    [len, ~] = size(vector);
    size(vct);
    if (len !=1)
        vct = vct(:);
    else
        vct = vct;
    endif

    stats(1) = mean(vct);
    stats(2) = median(vct);
    stats(3) = var(vct);
    stats(4) = std(vct); % standard deviation
    stats(5) = mad(vct); % mean absolute deviation
endfunction