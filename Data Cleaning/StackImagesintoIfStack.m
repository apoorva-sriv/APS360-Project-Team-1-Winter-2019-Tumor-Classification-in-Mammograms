clc; clear;
tic

outer_folders = {'I:\Project Data\FinalData\normal', ...
    'I:\Project Data\FinalData\abnormal\benign (label to be merged into abnormal)', ...
    'I:\Project Data\FinalData\abnormal\bwc (label to be merged into abnormal)', ...
    'I:\Project Data\FinalData\abnormal\cancer (label to be merged into abnormal)'}';

for j = 1:numel(outer_folders)
    outer_folder = outer_folders{j};
    
    % Left
    disp('LEFT');
    CC_folder = fullfile(outer_folder, 'LEFT_CC');
    MLO_folder = fullfile(outer_folder, 'LEFT_MLO');
    
    d = dirPlus(CC_folder);
    
    for i = 1:numel(d)
        disp(i);
        [~, name, ext] = fileparts(d{i});
        I1 = imread(d{i});
        I2 = imread(fullfile(MLO_folder, strcat(name, ext)));
        tif_stack = fullfile(outer_folder, strcat(name, '_LEFT.tif'));
        imwrite(I1, tif_stack, 'WriteMode', 'append');
        imwrite(I2, tif_stack, 'WriteMode', 'append');
    end
    
    % Right
    disp('RIGHT')
    CC_folder = fullfile(outer_folder, 'RIGHT_CC');
    MLO_folder = fullfile(outer_folder, 'RIGHT_MLO');
    
    d = dirPlus(CC_folder);
    
    for i = 1:numel(d)
        disp(i);
        [~, name, ext] = fileparts(d{i});
        I1 = imread(d{i});
        I2 = imread(fullfile(MLO_folder, strcat(name, ext)));
        tif_stack = fullfile(outer_folder, strcat(name, '_RIGHT.tif'));
        imwrite(I1, tif_stack, 'WriteMode', 'append');
        imwrite(I2, tif_stack, 'WriteMode', 'append');
    end
end

toc