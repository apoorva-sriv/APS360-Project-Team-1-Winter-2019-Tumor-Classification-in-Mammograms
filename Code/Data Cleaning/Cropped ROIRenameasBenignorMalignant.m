clear; clc
%%
tic

% Import the SORTED csv manually for each of the four cases.
d = sort(dirPlus('J:\CBIS-DDSM (cropped ROI renamed and masks deleted)\CBIS-DDSM Mass-Training-ROI'));            % to GUARANTEE that it is sorted in the ascending order (like the sorted csv)!

for i = 1:numel(d)
    [filepath, name, ext] = fileparts(d{i});
    if contains(string(pathology(i)), 'benign', 'IgnoreCase', true)        % pathology is the variable containing the column vector from MATLAB GUI > Home > Import Data > as column vectors! Exclude rows with unimportable cells.
        s = strcat(name, '_benign');
    else
        s = strcat(name, '_malignant');
    end
    s = strcat(s, '.dcm');
    disp(fullfile(filepath, s));
    movefile(d{i}, fullfile(filepath, s));
end

toc
