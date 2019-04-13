clc; clear;

folders = {'I:\Project Data\FINAL Data (512 x 512 x 2) split into training, validation, and test\training', ...
'I:\Project Data\FINAL Data (512 x 512 x 2) split into training, validation, and test\validation', ...
'I:\Project Data\FINAL Data (512 x 512 x 2) split into training, validation, and test\test'};

for i = 1:numel(folders)
    folder = folders{i};
    normal = fullfile(folder, 'normal');
    abnormal = fullfile(folder, 'abnormal');
    
    movefile(fullfile(folder, '*normal*'), normal);
    movefile(fullfile(folder, '*benign*'), abnormal);
    movefile(fullfile(folder, '*bwc*'), abnormal);
    movefile(fullfile(folder, '*cancer*'), abnormal);
end
