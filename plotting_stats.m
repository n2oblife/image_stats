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
    resized_cumsum = 100/cumul_sum(len)*cumul_sum;

    % [mean_, median_, var_, std_, mad_] = stats;
    mean_ = stats(1);
    median_ = stats(2);
    var_ = stats(3);
    std_ = stats(4);
    mad_ = stats(5);

    plot((1:len), resized_cumsum, 'k--',
        (1:len),histo, 'm',
        [mean_,mean_], [0, max_height], 'r',
        [median_,median_], [0, max_height], 'g',
        % [mean_ - var_,mean_ - var], [0, max_height], 'b--',
        % [mean_ + var_,mean_ + var], [0, max_height], 'b--',
        % [median_ - std_,median_ - std_], [0, max_height], 'y--',
        % [median_ + std_,median_ + std_], [0, max_height], 'y--',
        [median_ - acc_fact*std_,median_ - acc_fact*std_], [0, max_height], 'c--',
        [median_ + acc_fact*std_,median_ + acc_fact*std_], [0, max_height], 'c--',
        [median_ - acc_fact*mad_,median_ - acc_fact*mad_], [0, max_height], 'b--',
        [median_ + acc_fact*mad_,median_ + acc_fact*mad_], [0, max_height], 'b--'
        );   
    title("Histogram with mean and standard deviation lines");
    xlabel("Pixel value");
    ylabel("Frequency");
    legend("Cumulative sum","Histogram", "Mean", "Median");
endfunction