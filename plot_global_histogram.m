function stats = plot_global_histogram(
    filename, depth = 14, acc_fact = 5, h=480, w=640, show_fig = true
    )
    #
    # Usage : plot_stats(histo, stats)
    #   Plots the histogram of the image with the mean and standard deviation lines
    #
    # Parameters :
    #   filename (char) : path to the file (in unix style) from which to plot statistics
    #   depth (int) : depth of the pixels, default = 14
    #   acc_fact (int) : acceptability factor for the histogram, default = 5
    #   h (int) : height of the image, number of lines
    #   w (int) : width of the image, number of columns
    #
    % read the file whatver the extension
    img_mtx = read_img_file(filename, h, w);

    histo = histogram_mtx(img_mtx, depth);
    stats = stats_vector(img_mtx)
    
    if (show_fig)
        plotting_stats(histo, stats, acc_fact);
    endif
endfunction


