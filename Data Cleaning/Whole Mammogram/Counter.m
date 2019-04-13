clc; clear;

folders = {'I:\Project Data\FINAL Data (512 x 512 x 2) split into training, validation, and test\training', ...
'I:\Project Data\FINAL Data (512 x 512 x 2) split into training, validation, and test\validation', ...
'I:\Project Data\FINAL Data (512 x 512 x 2) split into training, validation, and test\test'};

for i = 1:numel(folders)
    folder = folders{i};
    folder_name = split(folder, '\');
    folder_name = folder_name{end};
    disp(folder_name);
    normal = numel(dirPlus(folder, 'PrependPath', false, 'FileFilter', 'normal'));
    fprintf('Normal count = %d\n', normal);
    abnormal = numel(dirPlus(folder, 'PrependPath', false, 'FileFilter', 'benign|bwc|cancer'));
    fprintf('Abnormal count = %d\n\n', abnormal);
end
