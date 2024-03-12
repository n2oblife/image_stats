global handeled_list = zeros(1,2^32);
global writing_idx = 1;

function scan_files(initialPath, extensions, fileHandler, args)
    # 
    # Usage : scan_files(initialPath, extensions, fileHandler)
    #   Parse a path and all its directories to apply the fileHandler on the files
    #   with the correct extension
    #
    # Parameters :
    #   initialPath (char) : path of the first directory to parse
    #   extension (char) : extension of the file to handle
    #   fileHandler (function) : function to apply to the found files
    #
    persistent total = 0;
    persistent depth = 0; depth++;
    initialDir = dir(initialPath);

    printf('Scanning the directory %s ...\n', initialPath);

    for idx = 1 : length(initialDir) 
        curDir = initialDir(idx);
        curPath = strcat(curDir.folder, '\', curDir.name);

        if regexp(curDir.name, "(?!(\\.\\.?)).*") * curDir.isdir
            scanFiles(curPath, extensions, fileHandler);
        elseif regexp(curDir.name, cstrcat("\\.(?i:)(?:", extensions, ")$"))
            total++;
            file = struct("name",curDir.name,
                            "path",curPath,
                            "parent",regexp(curDir.folder,'[^\\\/]*$','match'),
                            "bytes",curDir.bytes);
            
            handeled_list(writing_idx) = fileHandler(cstrcat(file.path, file.name));
            writing_idx += 1;
        endif
    end

    if!(--depth)
        printf('Total number of files:%d\n', total);
        total=0;
    endif
endfunction