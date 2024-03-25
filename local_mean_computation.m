function stas_mat = local_mean_computation(img_mtx, kernel_size=3, steps=1)
    %
    % Usage : local_mean_computation(img_mtx, kernel_size, steps)
    %   Function to compute local mean of an image
    %
    % Parameters:
    %   img_mtx (matrix): Input image matrix
    %   kernel_size (int): Size of the kernel, default is 3
    %   steps (int): Step size for iteration, default is 1
    %
    % Returns :
    %   stats_mat (matrix) : matrix with overall stats of the image
    %
    [h,w] = size(img_mtx);
    border = floor(kernel_size/2); % Calculate border size

    stats_cell = cell(1,(h-2*border)*(w-2*border)); % Preallocate cell array

    % Loop over the image with no padding
    for i=1+border:steps:h-border
        for j=1+border:steps:w-border
            % Display completion status
            completion((h-2*border)*(w-2*border)/steps, ((i-(1+border))*(w-2*border)+(j-border))/steps , "Computing local histogram ");

            % Compute local statistics using stats_filter function
            stats_cell(1,(i-(1+border))*(w-2*border)+(j-border)) = stats_filter(img_mtx, i, j, kernel_size);
        endfor
    endfor
    fprintf("\n"); % Print newline
    stas_mat = cellToMat(stats_cell); % Convert cell array to matrix
endfunction

function local_stats = stats_filter(img_mtx, x, y, kernel_size=3)
    %
    % Usage : stats_filter(img_mtx, x, y, kernel_size)
    %   Function to compute statistics of a local region in an image
    %
    % Parameters:
    %   img_mtx (matrix): Input image matrix
    %   x (int): x-coordinate of the center of the local region
    %   y (int): y-coordinate of the center of the local region
    %   kernel_size (int): Size of the kernel, default is 3
    %
    % Returns :
    %   local_stats (array) : mean, median, variance, std and mad of local region
    local_histo = kernel_values(img_mtx, x, y, kernel_size); % Get kernel values
    local_stats = stats_vector(local_histo); % Compute statistics vector
endfunction
