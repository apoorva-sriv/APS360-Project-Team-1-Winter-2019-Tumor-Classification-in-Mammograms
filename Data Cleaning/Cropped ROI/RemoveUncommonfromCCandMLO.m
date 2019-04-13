clear; clc;
tic

d = dirPlus('J:\data (CC and MLO separate, augmented, 4 classes)\CC', 'PrependPath', false);
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

d = dirPlus('J:\data (CC and MLO separate, augmented, 4 classes)\MLO', 'PrependPath', false);
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

%%
% Now we have the CC and MLO file names containing the (possibly) common parts.

% First delete all non-common from CC.
d = dirPlus('J:\data (CC and MLO separate, augmented, 4 classes)\CC');   % the WHOLE path now (to delete)
CC_indices_to_delete = [];

for i = 1:numel(CC)          
    if ~any(contains(MLO, CC{i}))
        disp(i);
        CC_indices_to_delete = [CC_indices_to_delete i];
        delete(d{i});         % d contains the full filepaths for CC.
    end
end    

disp('-------------------------------------------------------------------');

% Then delete all non-common from MLO.
d = dirPlus('J:\data (CC and MLO separate, augmented, 4 classes)\MLO');   % the WHOLE path now (to delete)
MLO_indices_to_delete = [];

for i = 1:numel(MLO)          
    if ~any(contains(CC, MLO{i}))
        disp(i);
        MLO_indices_to_delete = [MLO_indices_to_delete i];
        delete(d{i});         % d contains the full filepaths for CC.
    end
end

new_CC_size = numel(dirPlus('J:\data (CC and MLO separate, augmented, 4 classes)\CC'));
new_MLO_size = numel(dirPlus('J:\data (CC and MLO separate, augmented, 4 classes)\MLO'));
fprintf('%s\n',  string(new_CC_size == new_MLO_size));     % They should have the same number of files at the end!

toc