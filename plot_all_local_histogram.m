function listOfStats = plot_all_local_histogram(initialPath, acc_fact = 5, kernel_size = 3, steps = 1, extension = '.bin')
    #
    # Usage : plot_all_local_histogram(initialPath, acc_fact, kernel_size, steps, extension)
    #   Plots statistics from local histograms of all files in the directory initialPath
    #
    # Parameters :
    #   initialPath (string) : the path to the directory containing the files
    #   acc_fact (int) : the acceptability factor for the local histograms
    #   kernel_size (int) : the size of the kernel for the local histograms
    #   steps (int) : the number of steps during the local histograms computation
    #   extension (string) : the extension of the files to be considered
    #
    initialDir = dir(initialPath);
    writing_idx = 0;
    listOfStats = cell(1,length(initialDir));
    printf('Scanning the directory - %s ...\n', initialPath);

    for idx = 1 : length(initialDir) 
        curDir = initialDir(idx);
        curPath = strcat(curDir.folder, '/', curDir.name);

        if !(curDir.isdir)
            file = struct("name",curDir.name,
                            "path",curPath,
                            "parent",regexp(curDir.folder,'[^\\\/]*$','match'),
                            "bytes",curDir.bytes);

            printf('Computing file - %s \n', file.name);
            % split the filenampath by parentpath, name and extension 
            [~,name_no_ext,~] = fileparts(file.name);
            depth = get_depth(name_no_ext);
            [h,w] = get_dim(file.name);

            writing_idx += 1;
            listOfStats(writing_idx) = plot_local_histogram(file.path, depth, acc_fact, kernel_size, h, w, steps, false);
            % listOfStats(writing_idx) = plot_global_histogram(file.path);
            % listOfStats

        endif
    endfor

    plotting_stats_of_stats(listOfStats);

endfunction


function many_stats = stats_on_stats(stats_vct)
    #
    # Usage : stats_on_stats(stats_vct)
    #   Returns the mean, median, variance and standard deviation of the given vector
    #   for each element of the vector.
    #
    # Parameters :
    #   stats_vct (vector) : the vector of statistics
    #
    # Returns :
    #   many_stats (vector) : the vector of statistics of the statistics
    #

    many_stats = zeros(1,4);

    img_stats(1) = mean(stats_vct);
    img_stats(2) = median(stats_vct);
    img_stats(3) = var(stats_vct);
    img_stats(4) = std(stats_vct); % standard deviation
    img_stats(5) = mad(stats_vct); % mean absolute deviation
    
endfunction

function plotting_stats_of_stats(listOfStats)
    #
    # Usage : plotting_stats_of_stats(listOfStats)
    #   Plots the statistics of the statistics of the local histograms sorted by median
    #
    # Parameters :
    #   listOfStats (cell) : the cell containing the statistics of the local histograms
    #
    listOfStats
    listOfStats = cell2mat(listOfStats);
    printf('Stats on the std of all images :\n');
    std_stats = stats_on_stats(listOfStats(:, 4))
    printf('Stats on the mad of all images :\n');
    mad_stats = stats_on_stats(listOfStats(:,5))

    sorted_stats = sortrows(listOfStats, 2);
    plot(sorted_stats(:,2), sorted_stats(:,4),
         sorted_stats(:,2), sorted_stats(:,5)
         )
    title("Graph of std and mad according to med");
    legend("Standard deviation", "Median absolute deviation");
endfunction