function mtx_img = img_bin_to_mtx(filename, h, w,depth, show_img=false)
  # Usage : img_bin_to_mtx(filename, h, w, precision)
  #   A function which returns a converted matrix image of size (h,w) from a .bin
  #
  # Parameters :
  #   filename (char) : path to the file to be converted
  #   h (int) : height of the image, number of lines
  #   w (int) : width of the image, number of columns
  #   show_img (bool) : choosing to plot the image
  #
  # Returns :
  #   mtx_img (array of arrays) : image converted from the .bin file
  #
  if depth == 8
    int_type = 'uint8';
  elseif depth == 14
    int_type = 'uint16';
  endif
  fid = fopen(filename);
  bin_file = fread(fid, 2*h*w, int_type);
  mtx_img = zeros(h,w);
  for i=1:h
    for j=1:w
      mtx_img(i,j) = bin_file( (i-1)*w + j );
    endfor
  endfor

  if (show_img)
    imshow(mtx_img, gray(256));
  endif
  fclose(fid);
endfunction
