function std_list = test_std_stability(folder_path)
    folderDir = dir(folder_path);
    printf('Scanning the directory - %s ...\n', folderDir(1).folder);
    std_list = zeros(1, length(folderDir));

    % avoid taking . and .. into account by starting with 3
    for idx=3:length(folderDir)
        completion(length(folderDir), idx, "std computation completion ");

        curFile = folderDir(idx);
        curPath = strcat(curFile.folder, '/', curFile.name);

        [~,name_no_ext,~] = fileparts(curPath);
        depth = get_depth(name_no_ext);
        [h,w] = get_dim(name_no_ext);

        img_mtx = read_img_file(curPath, h, w, depth);
        
        stats_img = stats_vector(img_mtx);
        std_list(idx) = stats_img(4);
        idx += 1;
    end

    printf("\n");
    std_stats = stats_vector(std_list)
    sorted_std = sort(std_list);
    max = max(std_list)
    min = min(std_list)
    % -----------------------------
    plot(
        sorted_std, (1:length(sorted_std)),
        [std_stats(1), std_stats(1)], [0, length(sorted_std)], 'k--'
        );
    xlabel("std value");
    % -----------------------------
    % hist(std_list);
    % -----------------------------
    % histo = histogram_vector(std_list, round(depth/2));
    % plot((1:length(histo)), histo);
    % xlabel("Std value");
    % ylabel("Iteration");
    % -----------------------------
    title("Histogram of the std values through time");

endfunction

