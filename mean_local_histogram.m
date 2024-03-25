function mean_local_stats = mean_local_histogram(
    filename, depth=14, acc_fact = 5, kernel_size=3, h=480, w=640, steps = 1, show_fig = true
    )
    %
    % Usage: mean_local_histogram(filename, depth, acc_fact, kernel_size, h, w, steps, show_fig)
    %   Function to compute mean local histogram statistics
    %
    % Parameters :
    %   filename (char): Name of the image file to be processed
    %   depth (int): Bit depth of the image, default is 14
    %   acc_fact (int): Accumulation factor, default is 5
    %   kernel_size (int): Size of the kernel for local mean computation, default is 3
    %   h (int): Height of the image, default is 480
    %   w (int): Width of the image, default is 640
    %   steps (int): Step size for iteration, default is 1
    %   show_fig (logical): Flag to control whether to display figures, default is true
    %
    % Returns :
    %   mean_local_stats (array): Array containing mean statistics of local histograms,
    %       including mean, median absolute deviation, variance, standard deviation,
    %       and median absolute deviation of the local histograms
    %

    % read the file whatever the extension
    img_mtx = read_img_file(filename, h, w, depth); % Read image file

    all_local_stats = local_mean_computation(
        img_mtx, kernel_size, steps
        ); % Compute local mean statistics

    % Compute mean of all local statistics
    full_mean = mean(all_local_stats(:,1)); % Mean of mean values
    full_med = mean(all_local_stats(:,2)); % Mean of median values
    full_var = mean(all_local_stats(:,3)); % Mean of variance values
    full_std = mean(all_local_stats(:,4)); % Mean of standard deviation values
    full_mad = mean(all_local_stats(:,5)); % Mean of median absolute deviation values

    % Combine mean statistics into a single array
    mean_local_stats = [full_mean, full_mad, full_var, full_std, full_mad];
endfunction
