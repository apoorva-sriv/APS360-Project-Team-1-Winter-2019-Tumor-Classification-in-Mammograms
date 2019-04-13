clear; clc;
tic

d = dirPlus('J:\CBIS-DDSM ROI (added benign or malignant labels)\train');

% # training\benign = 1683

% 20% of benign calc
for i = 1:200
    movefile(d{i}, 'J:\CBIS-DDSM ROI (added benign or malignant labels)\val\benign');
end

% 20% of benign mass
for i = 1003:1137
    movefile(d{i}, 'J:\CBIS-DDSM ROI (added benign or malignant labels)\val\benign');
end

d = dirPlus('J:\CBIS-DDSM ROI (added benign or malignant labels)\train\malignant');

% # training\malignant = 1181

% 20% of malignant calc
for i = 1:108
    movefile(d{i}, 'J:\CBIS-DDSM ROI (added benign or malignant labels)\val\malignant');
end

% 20% of malignant mass
for i = 545:671
    movefile(d{i}, 'J:\CBIS-DDSM ROI (added benign or malignant labels)\val\malignant');
end
%%
% Move common between train and val to val.
common_patient = getCommonPatientIDsamongSets('J:\CBIS-DDSM ROI (added benign or malignant labels)\train', 'J:\CBIS-DDSM ROI (added benign or malignant labels)\val');

d = dirPlus('J:\CBIS-DDSM ROI (added benign or malignant labels)\train');   % Re-map after the moving above.

for i = 1:numel(d)
    if contains(d{i}, common_patient)
        disp(d{i});
        if contains(d{i}, 'benign')
            movefile(d{i}, "J:\CBIS-DDSM ROI (added benign or malignant labels)\val\benign");
        else
            movefile(d{i}, "J:\CBIS-DDSM ROI (added benign or malignant labels)\val\malignant");
        end
    end
end

toc