%clear; clc;
tic

CC_subsubfolders = {'J:\data (CC and MLO separate, augmented, 4 classes)\CC\test\benign calcification';
    'J:\data (CC and MLO separate, augmented, 4 classes)\CC\test\benign mass';
    'J:\data (CC and MLO separate, augmented, 4 classes)\CC\test\malignant calcification';
    'J:\data (CC and MLO separate, augmented, 4 classes)\CC\test\malignant mass';
    'J:\data (CC and MLO separate, augmented, 4 classes)\CC\train\benign calcification';
    'J:\data (CC and MLO separate, augmented, 4 classes)\CC\train\benign mass';
    'J:\data (CC and MLO separate, augmented, 4 classes)\CC\train\malignant calcification';
    'J:\data (CC and MLO separate, augmented, 4 classes)\CC\train\malignant mass';
    'J:\data (CC and MLO separate, augmented, 4 classes)\CC\val\benign calcification';
    'J:\data (CC and MLO separate, augmented, 4 classes)\CC\val\benign mass';
    'J:\data (CC and MLO separate, augmented, 4 classes)\CC\val\malignant calcification';
    'J:\data (CC and MLO separate, augmented, 4 classes)\CC\val\malignant mass'};

MLO_subsubfolders = {'J:\data (CC and MLO separate, augmented, 4 classes)\MLO\test\benign calcification';
    'J:\data (CC and MLO separate, augmented, 4 classes)\MLO\test\benign mass';
    'J:\data (CC and MLO separate, augmented, 4 classes)\MLO\test\malignant calcification';
    'J:\data (CC and MLO separate, augmented, 4 classes)\MLO\test\malignant mass';
    'J:\data (CC and MLO separate, augmented, 4 classes)\MLO\train\benign calcification';
    'J:\data (CC and MLO separate, augmented, 4 classes)\MLO\train\benign mass';
    'J:\data (CC and MLO separate, augmented, 4 classes)\MLO\train\malignant calcification';
    'J:\data (CC and MLO separate, augmented, 4 classes)\MLO\train\malignant mass';
    'J:\data (CC and MLO separate, augmented, 4 classes)\MLO\val\benign calcification';
    'J:\data (CC and MLO separate, augmented, 4 classes)\MLO\val\benign mass';
    'J:\data (CC and MLO separate, augmented, 4 classes)\MLO\val\malignant calcification';
    'J:\data (CC and MLO separate, augmented, 4 classes)\MLO\val\malignant mass'};


for h = 1:numel(CC_subsubfolders)
    d = dirPlus(CC_subsubfolders{h}, 'PrependPath', false);
    CC = string(zeros(numel(d), 1));

    for i = 1:numel(d)
        s = split(d{i}, '_');
        if numel(s) == 10              % test and val (unaugmented)
            CC(i) = strcat(s{1}, '_', s{2}, '_', s{3}, '_', s{4}, '_', s{6});
        elseif numel(s) == 12          % training (augmented)
            last = split(s{12}, '.');
            last = last{1};
            CC(i) = strcat(s{1}, '_', s{2}, '_', s{3}, '_', s{4}, '_', s{6}, '_', s{11}, '_', last);
        end
    end

    d = dirPlus(MLO_subsubfolders{h}, 'PrependPath', false);
    MLO = string(zeros(numel(d), 1));

    for i = 1:numel(d)
        s = split(d{i}, '_');
        if numel(s) == 10              % test and val (unaugmented)
            MLO(i) = strcat(s{1}, '_', s{2}, '_', s{3}, '_', s{4}, '_', s{6});
        elseif numel(s) == 12        % training (augmented)
            last = split(s{12}, '.');
            last = last{1};
            MLO(i) = strcat(s{1}, '_', s{2}, '_', s{3}, '_', s{4}, '_', s{6}, '_', s{11}, '_', last);
        end
    end
    
    if ~isequal(CC, MLO)          % e.g. if P_00000 LEFT CC 1 is marked benign but the same LEFT MLO is malignant in the csv! (We delete these cases (images) for now.)
        if numel(CC) < numel(MLO)
            disp(MLO_subsubfolders{h});
            disp(find(~ismember(MLO, CC)));    % indices of extra elements from the larger array (first)
        else
            disp(CC_subsubfolders{h});
            disp(find(~ismember(CC, MLO)));    % indices of extra elements from the larger array (first)
        end
    end
end

toc