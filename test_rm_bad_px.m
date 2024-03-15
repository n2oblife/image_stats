function [big_res, big_bound] = test_rm_bad_px(
    filepath, acc_fact = 5, kernel_size = 3, steps = 1, extension = '.bin', show_fig = true
    )
    #
    # Usage : stats = test_rm_bad_px(filepath, acc_fact, kernel_size, steps, extension)
    #
    [~,name_no_ext,~] = fileparts(filepath);
    depth = get_depth(name_no_ext);
    [h,w] = get_dim(name_no_ext);

    img_mtx = read_img_file(filepath, h, w, depth);
    histo = histogram_matrix(img_mtx, depth); 

    %% rpz des limites des zones d'acceptabilité avec maj des limites

    % extraction des px selon mediane globale et ecart type, distance a mediane globale
    global_stats = plot_global_histogram(
        filepath, depth, acc_fact +2, h, w, false
        );

    % extraction des px selon mediane des medianes locales et ecart type des medianes locale, distance a mediane des medianes locale
    % extraction des px selon mediane locale et moyenne des ecarts types locaux, moyene des distance a mediane locales 
    local_median_stats = plot_local_histogram(
        filepath, depth, acc_fact+2, kernel_size, h, w, steps, false
        );

    % extraction des px selon mediane local et ecart types locales, distance a mediane locale
    % pas d'acquisition, tout est bio et local

    % extraction des px selon mediane local et moyenne des ecart types locaux, distance a mediane moyene des histos locaux
    mean_stats = mean_local_histogram(
        filepath, depth, acc_fact+2, kernel_size, h, w, steps, false
        );

    % traitement global de l'image
    [res_global, bound_min_global, bound_max_global] = global_rm(
        img_mtx, global_stats(2), acc_fact*global_stats(4), h, w
        );
    
    % traitement globale selon la mediane des medianes local 
    [res_global_local_med, bound_min_global_local_med, bound_max_global_local_med] = global_rm(
        img_mtx, local_median_stats(2), acc_fact*local_median_stats(4), h, w
        );

    % traitement local selon la mediane des medianes locales
    [res_local_global_med, bound_min_local_global_med, bound_max_local_global_med] = local_rm(
        img_mtx, acc_fact*global_stats(4), kernel_size, h, w
        );

    % traitement local selon la mediane des medianes locales
    [res_local, bound_min_local, bound_max_local] = local_rm(
        img_mtx, 0, kernel_size, h, w
        );
    
    % traitement local selon la moyenne des histo locaux
    [res_local_mean, bound_min_local_mean, bound_max_local_mean] = local_rm(
        img_mtx, acc_fact*mean_stats(4), kernel_size, h, w
        );

    big_res = {res_global; res_global_local_med; res_local_global_med; res_local; res_local_mean};
    big_bound = [bound_min_global, bound_max_global;
        bound_min_global_local_med, bound_max_global_local_med;
        bound_min_local_global_med, bound_max_local_global_med;
        bound_min_local, bound_max_local;
        bound_min_local_mean, bound_max_local_mean
    ];
    
    if show_fig
        plot_overall(img_mtx, histo, big_res, big_bound);
    endif
endfunction


function [res, bound_min, bound_max] = global_rm(
    img_mtx, mid, threshold, h=480,w=640
    )
    res = zeros(h,w);
    for i = 1:h
        for j = 1:w 
            completion(h*w, (i-1)*w+j , "Parsing image for cleaning bad pixels ");
            if (img_mtx(i,j) < mid - threshold || img_mtx(i,j) > mid + threshold)
                res(i,j) = 256;
            endif
        endfor
    endfor
    bound_min = mid - threshold;
    bound_max = mid + threshold;
    printf("\n");
endfunction


function [res, bound_min, bound_max] = local_rm(
    img_mtx, threshold=0, kernel_size = 3, h=480, w=640
    )
    % tells if there is a need to compute threshold each time
    update_threshold = (threshold == 0);
    % bound set to opposite value to force update at init
    bound_max = 0; bound_min = 256; 

    border = floor(kernel_size/2);
    res = zeros(h,w);
    for i = 1+border:h-border
        for j = 1+border:w-border
            completion((h-2*border)*(w-2*border), (i-(1+border))*(w-2*border)+(j-border) , "Parsing image for cleaning bad pixels ");
            % update acceptability parameters
            if update_threshold
                sorted_kernel = kernel_values(img_mtx, i, j, kernel_size);
                kernel_stats = stats_vector(sorted_kernel);
                mid = kernel_stats(2);
                threshold = kernel_stats(4);
            else
                mid = median_filter(img_mtx, i, j, kernel_size);
            endif

            % check pixel value
            if (img_mtx(i,j) < mid - threshold || img_mtx(i,j) > mid + threshold)
                res(i,j) = 256;
            endif

            % update the bound at each pixel to show acceptability zone
            if mid-threshold < bound_min
                bound_min = mid - threshold;
            endif
            if mid+threshold > bound_max
                bound_max = mid + threshold;
            endif
        endfor
    endfor
    printf("\n");
endfunction

function plot_overall(img_mtx, histo, big_res, big_bound)
    clf;
    depth = log2(length(histo));
    % plot og image
    imshow(img_mtx, gray(2^depth));
    title("Original picture");
    % plot images of the bad pixels
    imshow(big_res{1}, gray(2^depth));
    title("Original picture");
    imshow(big_res{2}, gray(2^depth));
    title("Original picture");
    imshow(big_res{3}, gray(2^depth));
    title("Original picture");
    imshow(big_res{4}, gray(2^depth));
    title("Original picture");
    imshow(big_res{5}, gray(2^depth));
    title("Original picture");

    % plot acceptabiilty zone according to global histo
    len=length(histo);
    max_height = max(histo);
    cumul_sum = cumsum(histo);
    resized_cumsum = max_height/cumul_sum(len)*cumul_sum;

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
