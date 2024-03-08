function completion(total, current, message)
    # 
    # Usage : completion(total, current, message)
    #   Print the completion percentage of a task when total operations are known
    #
    # Parameters:
    #   total: total number of operations
    #   current: current operation number
    #   message: message to be printed
    #
    percent = current / total * 100;
    last_size = fprintf('%s: %d/%d - %d%% \r', message, current, total, percent);
endfunction