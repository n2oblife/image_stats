function mean_local_stats = mean_local_histogram(
    filename, depth=14, acc_fact = 5, kernel_size=3, h=480, w=640, steps = 1, show_fig = true
    )
    #
    # Usage :
    #
    % read the file whatever the extension
    img_mtx = read_img_file(filename, h, w, depth);

    all_local_stats = local_mean_computation(
        img_mtx, kernel_size, steps
        );
    full_mean = mean(all_local_stats(:,1));
    full_med = mean(all_local_stats(:,2));
    full_var = mean(all_local_stats(:,3));
    full_std = mean(all_local_stats(:,4));
    full_mad = mean(all_local_stats(:,5));
    mean_local_stats = [full_mean, full_mad, full_var, full_std, full_mad];
endfunction

function stas_mat = local_mean_computation(img_mtx, kernel_size=3, steps=1)
    [h,w] = size(img_mtx);
    border = floor(kernel_size/2);

    stats_cell = cell(1,(h-2*border)*(w-2*border));

    % for loops on the image with no padding
    for i=1+border:steps:h-border
        for j=1+border:steps:w-border
            % completion status
            completion((h-2*border)*(w-2*border)/steps, ((i-(1+border))*(w-2*border)+(j-border))/steps , "Computing local histogram ");
            stats_cell(1,(i-(1+border))*(w-2*border)+(j-border)) = stats_filter(img_mtx, i, j, kernel_size);
        endfor
    endfor
    fprintf("\n");
    stas_mat = cellToMat(stats_cell);
endfunction

function local_stats = stats_filter(img_mtx, x, y, kernel_size=3)
    local_histo = kernel_values(img_mtx, x, y, kernel_size);
    local_stats = stats_vector(local_histo);
endfunction