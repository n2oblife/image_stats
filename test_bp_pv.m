function pos_list = test_bp_pv(
    file_path, acc_fact = 5, kernel_size = 3, steps = 1, extension = '.bin', show_fig = true
    )
    %
    % Usage : pos_list = test_bp_pv(file_path, acc_fact, kernel_size, steps, extension, show_fig)
    %   Function to test the algorithm to identify bad pixels from an image
    %
    % Parameters :
    %   file_path (char): Path to the image file
    %   acc_fact (int): Accumulation factor, default is 5
    %   kernel_size (int): Size of the kernel for local processing, default is 3
    %   steps (int): Step size for iteration, default is 1
    %   extension (char): Extension of the image file, default is '.bin'
    %   show_fig (logical): Flag to control whether to display figures, default is true
    %
    % Returns :
    %   pos_list (matrix): List of positions of bad pixels
    %

    % Call the test_rm_bad_px function to get the results and boundaries
    [big_res, big_bound, h, w] = test_rm_bad_px(
        file_path, acc_fact, kernel_size, steps, extension, show_fig
        );

    % Extract the matrix from the cell array
    res_local_mean_matrix = big_res(5){1}.'; % to get the matrix from output and then transpose it

    % Find the positions of the bad pixels in a list
    pos_list = find(res_local_mean_matrix == 256);

    % Unbias the pos_list by subtracting 1 from each element
    pos_list = pos_list - 1;

    % Alternatively, you can get the row and column indices of the bad pixels
    % [row, col] = ind2sub([h, w], res_local_mean_matrix); % vectors containing the row and column indices of the bad pixels, respectively
endfunction
