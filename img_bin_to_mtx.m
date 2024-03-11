function mtx_img = img_bin_to_mtx(filename, h, w, show=false)
  # Usage : img_bin_to_mtx(filename, h, w, precision)
  #   A function which returns a converted matrix image of size (h,w) from a .bin
  #
  # Parameters :
  #   filename (char) : path to the file to be converted
  #   h (int) : height of the image, number of lines
  #   w (int) : width of the image, number of columns
  #
  # Returns :
  #   mtx_img (array of arrays) : image converted from the .bin file
  #
  fid = fopen(filename);
  bin_file = fread(fid);
  mtx_img = zeros(h,w);
  for i=1:h
    for j=1:w
      mtx_img(i,j) = bin_file( (i-1)*w + j );
    endfor
  endfor

  if (show)
    imshow(mtx_img);
  endif
  fclose(fid);
endfunction
