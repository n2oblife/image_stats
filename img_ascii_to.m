function txt_dec = convert_ascii_to_dec(filename, data_size_rd, precision='uint8', file_size=1280, word_size=8, MSBs=2)
    #
    # Usage : convert_ascii_to_dec(filename, data_size_rd, precision='uint8', file_size=1280, word_size=8, MSBs=2)
    #  Convert a binary file to a decimal array
    #
    # Parameters :
    #   filename (char) : the name of the file to convert
    #   data_size_rd (int) : the size of the data to read in bits
    #   precision (char) : the precision of the data to read, default = 'uint8'
    #   file_size (int) : the size of the file to read, default = 1280
    #   word_size (int) : the size of the word to read in bits, default = 8
    #   MSBs (int) : the number of MSBs to take into account, default = 2
    #
    # Returns :
    #   txt_dec (array) : value of the intensity of the pixels in dec
    #
    % loading the file in read only binary
    fid = fopen(filename);
    len = file_size*2*data_size_rd / word_size;
    ram_txt = fread(fid, len, precision);

    txt_dec = zeros(1, file_size);

    % parsing the text to change from bin to value
    for i=1:len
        ram_txt(i) = convert_bin_to_value(ram_txt(i));
    endfor

    % size of the value to read
    step = 2*data_size_rd / word_size;
    % parsing every word with only first two elements relevants (MSB ?)
    % and converting them from 0xXX to XXX
    for i=1:file_size
        txt_dec(i) = hex_to_dec(strcat(ram_txt(step*(i-1)+1:step*i)),MSBs);
        % txt_dec(i) = ram_txt(step*(i-1) + 1)*16 + ram_txt(step*(i-1) + 2);
    endfor
endfunction

function value = convert_bin_to_value(raw_txt)
    # 
    # Usage : convert_bin_to_value(raw_txt)
    #  Convert a raw text value to a decimal value
    #
    # Parameters :
    #   raw_txt (char) : the raw text value to convert
    #
    # Returns :
    #   value (int) : the decimal value of the raw text
    #
    if (raw_txt >= '0' && raw_txt <= '9')
        value = raw_txt -'0';
    else if (raw_txt >= 'A' && raw_txt <= 'F')
        value = raw_txt -'A'+10; % because A is 10 in hex
    else if (raw_txt >= 'a' && raw_txt <= 'f')
        value = raw_txt -'a'+10; % because a is 10 in hex
    else
        value = 0; % if not a valid value, set to 0
    endif
endfunction

function dec_value = hex_to_dec(hex_str, MSBs = 2)
    #
    # Usage : hex_to_dec(hex_str, MSBs)
    #   Convert a hex string to a decimal value while only taking into account the MSBs
    #
    # Parameters :
    #   hex_str (char) : the hex string to convert MSB -> LSB
    #   MSBs (int) : the number of MSBs to take into account, default = 2
    #
    # Returns :
    #   dec_value (int) : the decimal value of the hex string
    #
    [~, len_str] = size(hex_str);
    dec_value = 0;
    for i=1:MSBs
        dec_value = dec_value + hex_str(i)*16^(MSBs-i);
    endfor
endfunction
