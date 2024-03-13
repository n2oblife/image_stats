function stats = test_rm_bad_px(
    filepath, acc_fact = 3, kernel_size = 3, steps = 1, extension = '.bin'
    )
    [~,name_no_ext,~] = fileparts(filepath);
    depth = get_depth(name_no_ext);
    [h,w] = get_dim(name_no_ext);

    img_mtx = read_img_file(filepath);
    histo = histogram_mtx(img_mtx, depth); 

    %% rpz des limites des zones d'acceptabilité

    % extraction des px selon mediane globale et ecart type, distance a mediane globale
    % extraction des px selon mediane des medianes locales et ecart type des medianes locale, distance a mediane des medianes locale
    % extraction des px selon mediane locale et moyenne des ecarts types locaux, moyene des distance a mediane locales 
    % extraction des px selon mediane local et moyenne des ecart types des medianes locales, distance a mediane des medianes locale

endfunction


function global_test
    stats = plot_global_histogram(
        filepath, depth, acc_fact +2, h, w, false
    )
endfunction

function median_histo_test
    stats = plot_local_histogram(
        filenampath, depth, acc_fact+2, kernel_size, h, w, steps, false
    )
endfunction

function local_test
endfunction

function local_median_histo_test
    stats = plot_local_histogram(
        filenampath, depth, acc_fact+2, kernel_size, h, w, steps, false
    )
endfunction


function mean_local_test
endfunction

function report_bad_px(img_mtx, list_bad_px)
    [h, w] = size(img_mtx)
    reported = zeros(h,w)
    for pos 
endfunction