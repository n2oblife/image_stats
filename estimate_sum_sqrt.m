function estimate_sum_sqrt(list_values, precision = 0)
    %
    % Usage : estimate_sum_sqrt(list_values, precision)
    %   Function to estimate the sum of square roots of a list of values
    %
    % Parameters:
    %   list_values (array): List of values
    %   precision (int): Precision level for the estimation, default is 0
    %
    len = length(list_values);
    correct_sum = 0;
    estimate_sum = 0;

    % Loop to compute correct and estimated sums
    for i=1:len
        correct_sum += sqrt(list_values(i));
        estimate_sum += list_values(i);
    endfor

    correct_sum /= len; % Compute the average of correct sum
    estimate_sum /= len; % Compute the average of estimated sum
    estimate_sum = sqrt(estimate_sum);

    m = min(list_values) - estimate_sum; % Compute minimum deviation
    M = max(list_values) - estimate_sum; % Compute maximum deviation

    % Call compute_estimation function to refine estimation
    [estimate_sum, condition] = compute_estimation(estimate_sum, m, -m, precision);
endfunction


function [estimate_sum, error] = compute_estimation(estimate_sum, m, M, precision = 0)
    %
    % Usage : compute_estimation(estimate_sum, m, M, precision)
    %   Function to refine the estimation of the sum
    %
    % Parameters:
    %   estimate_sum (float): Estimated sum to refine
    %   m (float): Minimum deviation
    %   M (float): Maximum deviation
    %   precision (int): Precision level for the estimation, default is 0
    %
    % Returns : 
    %   estimate_sum (float) : estimation of the sum refined
    %   error (float) : error and validity of the estimation condition
    %
    if precision == 1
        fact = (1 + (m+M)/(4*estimate_sum)); % Factor for precision level 1
    elseif precision == 2
        fact = (1 + (m+M)/(4*estimate_sum)-(m^2+M^2)/(8*estimate_sum^2)); % Factor for precision level 2
    else
        fact = 1; % Default factor
    endif

    estimate_sum *= fact; % Refine the estimate

    error = max(abs(m), abs(M)) / estimate_sum; % Compute the error
endfunction
