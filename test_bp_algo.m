function [value_list,compare_list] = test_bp_algo(
    filename, depth=8,  h=480, w=640, acc_fact = 5, kernel_size=3, steps = 1, show_fig = true, compare=true, compare_path = "../list.lst"
    )
    %
    % Usage: test_bp_algo(filename, depth, acc_fact, kernel_size, h, w, show_fig, compare, compare_path)
    %   Function to test bp algo
    %
    % Parameters :
    %   filename (char): Name of the image file to be processed
    %   depth (int): Bit depth of the image, default is 8
    %   h (int): Height of the image, default is 480
    %   w (int): Width of the image, default is 640
    %   acc_fact (int): Accumulation factor, default is 5
    %   kernel_size (int): Size of the kernel for local mean computation, default is 3
    %   steps (int): Step size for iteration, default is 1
    %   show_fig (logical): Flag to control whether to display figures, default is true
    %   compare (logical) : Flag to compare list with another list, default false
    %   compare_path (char) : path to the list to compare, default .
    %

    % read the file whatever the extension
    img_mtx = read_img_file(filename, h, w, depth);
    border = floor(kernel_size/2); % Calculate border size

    value_list = zeros(1,(h-2*border)*(w-2*border));
    acc_var = 0;


    for i=1+border:steps:h-border
        for j=1+border:steps:w-border
            completion((h-2*border)*(w-2*border)/steps, ((i-(1+border))*(w-2*border)+(j-border))/steps , "Computing local variances ");

            local_kernel = kernel_values(img_mtx, i, j, kernel_size);
            p1 = pipe1(local_kernel);
            p2 = pipe2(local_kernel);
            acc_var += p1 - p2;
            value_list(1,(i-(1+border))*(w-2*border)+(j-border)) = acc_var;
        endfor
    endfor
    fprintf("\n"); % Print newline
    fprintf("Variance accumulation value : %d\n", acc_var);

    if compare
        value_list = dec2bin(value_list);
        if (compare_path=="." || compare_path!="../list.lst")
            compare_path = input("Enter path to comparing list from Liberio :\n");
        endif
        compare_list = fileread(compare_path);
        compare_list = build_list_from_lst(compare_list);
        fprintf("\n");
        fprintf("Let s compare the lists \n");
        same_list = check_lists(value_list, compare_list);
        fprintf("\n");
        if same_list
            fprintf("Lists are the same\n");
        else
            fprintf("Lists are different\n");
        endif
    endif
endfunction

function p1 = pipe1(kernel_values)
    p1 = 0;
    klen = length(kernel_values);
    for idx= 1:klen
        p1 += kernel_values(idx)^2;
    endfor
    p1 *= klen;
endfunction

function p2 = pipe2(kernel_values)
    p2 = sum(kernel_values)^2;
endfunction

function clean_list = build_list_from_lst(lst, line_size = 62)
    clean_list = cell(1,length(lst)/line_size);
    clen = length(clean_list);

    for idx = 1:clen-1
        completion(clen, idx, "Cleaning the list ");
        clean_list(1,idx) = lst(idx*line_size+31:idx*line_size+60)();
    endfor
    % clean_list = cellToMat(clean_list);
endfunction

function [same_lists, error_idx] = check_lists(val_list, comp_list)
    len1 = length(val_list);
    len2 = length(comp_list);

    same_lists = true;

    len = min(len1, len2);

    for idx = 1:len
        completion(len, idx, "Comparing the lists ");
        if (val_list(idx,1:29) != comp_list{1,idx}(2:30))
            same_lists = false;
            fprintf("\n");
            fprintf("%dth is wrong \n", idx);
        endif
    endfor
endfunction