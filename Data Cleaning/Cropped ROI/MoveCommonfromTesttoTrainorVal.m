%{
% Import patient IDs, using Output type: String array, from "C:\Users\Apoorva\Desktop\CBIS Training Patient IDs.csv" and "C:\Users\Apoorva\Desktop\CBIS Test Patient IDs.csv").
train = join(CBISTrainingPatientIDs, '_');
test = join(CBISTestPatientIDs, '_');
%a_csv = test(ismember(test, train))  % SOURCE MUST BE FIRST TO FIND THE
%NUMBER OF FILES USING ismember to move FROM source!
common = intersect(train, test);     % removes duplicates. Use test(ismember(test, train)) to get the total number including duplicates.
%}

clc;
tic

d = dirPlus('J:\data (unaugmented, 2 classes, dcm)\test');

% test --> train
common = getCommonPatientIDsamongSets('J:\data (unaugmented, 2 classes, dcm)\test', 'J:\data (unaugmented, 2 classes, dcm)\train');

count = 0;
for i = 1:numel(d)
    if contains(d{i}, common)
        count = count + 1;
        [filepath, name, ext] = fileparts(d{i});
        name = strrep(name, "Test", "Training");
        if contains(d{i}, 'benign')
            movefile(d{i}, fullfile("J:\data (unaugmented, 2 classes, dcm)\train\benign", strcat(name, ext)));
        else
            movefile(d{i}, fullfile("J:\data (unaugmented, 2 classes, dcm)\train\malignant", strcat(name, ext)));
        end
    end
end

% test --> val
common = getCommonPatientIDsamongSets('J:\data (unaugmented, 2 classes, dcm)\test', 'J:\data (unaugmented, 2 classes, dcm)\val');

count = 0;
for i = 1:numel(d)
    if contains(d{i}, common)
        count = count + 1;
        [filepath, name, ext] = fileparts(d{i});
        name = strrep(name, "Test", "Training");
        if contains(d{i}, 'benign')
            movefile(d{i}, fullfile("J:\data (unaugmented, 2 classes, dcm)\val\benign", strcat(name, ext)));
        else
            movefile(d{i}, fullfile("J:\data (unaugmented, 2 classes, dcm)\val\malignant", strcat(name, ext)));
        end
    end
end

toc