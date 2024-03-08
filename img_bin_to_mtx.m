function mtx_img = img_bin_to_mtx(filename, h, w, precision = 'uint16')
  # Usage : img_bin_to_mtx(filename, h, w, precision)
  #   A function which returns a converted matrix image of size (h,w) from a .bin
  #
  # Parameters :
  #   filename (char) : path to the file to be converted
  #   h (int) : height of the image, number of lines
  #   w (int) : width of the image, number of columns
  #   precision (char) : specifying the type of data to read, default = 'uint16'
  #
  # Returns :
  #   mtx_img (array of arrays) : image converted from the .bin file
  #
  fid = fopen(filename);
  bin_file = fread(fid, 2*h*w, precision);
  mtx_img = zeros(h,w);
  for i=1:h
    for j=1:w
      mtx_img(i,j) = bin_file( (i-1)*w + j );
    endfor
  endfor
  imshow(mtx_img);
  ~ = fclose(fid);
endfunction
