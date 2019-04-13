function p = getCommonPatientIDsamongSets(folder1, folder2)
    
    % folder1 (argument) MUST be the source folder (test); otherwise, ismember will give
    % a different (based on the other array) result!
    folder1 = cellstr(folder1);              % Convert double quotes to single quotes cell for dirPlus.
    folder1 = folder1{1};
    d = dirPlus(folder1, 'FileFilter', '\.dcm$');
    if ~numel(d)
        error('folder1 has 0 elements!');
    end
    a = split(d, '\');   % ALITER: Use 'PrependPath', false in dirPlus!
    b = a(:, end);
    c = split(b, '_');
    c = c(:, 1:4);
    y1 = string(zeros(length(c), 1));
    for i = 1:length(c)
        y1(i) = string(strcat(c(i, 2), '_', c(i, 3)));
    end
    z1 = unique(y1);
    
    % folder2 (argument) MUST be the destination folder (train); otherwise, ismember will give
    % a different (based on the other array) result!
    folder2 = cellstr(folder2);
    folder2 = folder2{1};
    d = dirPlus(folder2, 'FileFilter', '\.dcm$');
    if ~numel(d)
        error('folder2 has 0 elements!');
    end
    a = split(d, '\');    % ALITER: Use 'PrependPath', false in dirPlus!
    b = a(:, end);
    c = split(b, '_');
    c = c(:, 1:4);
    y2 = string(zeros(length(c), 1));
    for i = 1:length(c)
        y2(i) = string(strcat(c(i, 2), '_', c(i, 3)));
    end
    z2 = unique(y2);
    
    %p = intersect(z1, z2);         % It's better to use intersect to avoid confusion with the source and destination!
    p = y1(ismember(y1, y2));     % The source folder MUST be first for
    %ismember. Will give a smaller number if y1 < y2 and larger number if
    %y1 > y2; vice versa if y2 is first.
end