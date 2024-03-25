function plot_overall(img_mtx, histo, big_res, big_bound)
    % unique use 
    clf;
    depth = log2(length(histo));
    % plot og image
    imshow(img_mtx, gray(2^depth));
    title("Original picture");
    % plot images of the bad pixels
    figure();
    imshow(big_res{1}, gray(2^depth));
    title("Global");
    figure();
    imshow(big_res{2}, gray(2^depth));
    title("Global median");
    figure();
    imshow(big_res{3}, gray(2^depth));
    title("Local on global median");
    figure();
    imshow(big_res{4}, gray(2^depth));
    title("Local");
    figure();
    imshow(big_res{5}, gray(2^depth));
    title("Local mean");

    % plot acceptabiilty zone according to global histo
    len=length(histo);
    max_height = max(histo);
    cumul_sum = cumsum(histo);
    resized_cumsum = max_height/cumul_sum(len)*cumul_sum;

    figure();
    plot((1:len), resized_cumsum, 'k--',
        (1:len),histo, 'm',
        [big_bound(1,1),big_bound(1,1)], [0, max_height], 'c--',
        [big_bound(2,1),big_bound(2,1)], [0, max_height], 'g--',
        [big_bound(3,1),big_bound(3,1)], [0, max_height], 'b--',
        [big_bound(4,1),big_bound(4,1)], [0, max_height], 'y--',
        [big_bound(5,1),big_bound(5,1)], [0, max_height], 'r--',
        [big_bound(1,2),big_bound(1,2)], [0, max_height], 'c--',
        [big_bound(2,2),big_bound(2,2)], [0, max_height], 'g--',
        [big_bound(3,2),big_bound(3,2)], [0, max_height], 'b--',
        [big_bound(4,2),big_bound(4,2)], [0, max_height], 'y--',
        [big_bound(5,2),big_bound(5,2)], [0, max_height], 'r--'
    );
    title("Histogram with acceptability zone according to method");
    xlabel("Pixel value");
    ylabel("Iteration");
    % order of the plot to have correct legends
    legend("Cumulative sum",
        "Histogram", 
        "global", 
        "global median", 
        "local on global median",
        "local",
        "local mean"
        );
endfunction