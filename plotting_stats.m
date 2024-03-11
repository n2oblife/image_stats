function plotting_stats(histo, stats, acc_fact=5)
    #
    # Usage : ploting_stats(histo, stats, acc_fact)
    #   Plots the histogram (supposedly gaussian) with mean, median, std deviation 
    #   and acceptability zone for pixels
    #
    # Parameters :
    #   histo (array) : Histogram of values
    #   stats (array) : Array containing mean, mediane, variance and standard deviation of the histogram
    #   acc_fact (int) : Factor to see the acceptability zone around mean
    # 
    max_height = max(histo);
    [~,len]=size(histo);
    cumul_sum = cumsum(histo);

    resized_cumsum = max_height/cumul_sum(len)*cumul_sum;

    plot((1:len), resized_cumsum, 'k--',
        (1:len),histo, 'm',
        [stats(1),stats(1)], [0, max_height], 'r',
        [stats(2),stats(2)], [0, max_height], 'g',
        % [stats(1) - stats(3),stats(1) - stats(3)], [0, max_height], 'b--',
        % [stats(1) + stats(3),stats(1) + stats(3)], [0, max_height], 'b--',
        [stats(2) - stats(4),stats(2) - stats(4)], [0, max_height], 'y--',
        [stats(2) + stats(4),stats(2) + stats(4)], [0, max_height], 'y--',
        [stats(2) - acc_fact*stats(4),stats(2) - acc_fact*stats(4)], [0, max_height], 'c--',
        [stats(2) + acc_fact*stats(4),stats(2) + acc_fact*stats(4)], [0, max_height], 'c--'
        );   
    title("Histogram with mean and standard deviation lines");
    xlabel("Pixel value");
    ylabel("Frequency");
    legend("Cumulative sum","Histogram", "Mean", "Median");
endfunction