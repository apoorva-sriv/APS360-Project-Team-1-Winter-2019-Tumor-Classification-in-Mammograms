clc; clear;
tic

%d = dirPlus('jkJ:\CBIS-DDSM ROI\CBIS-DDSM Mass-Training-ROI');
for i = 1:2:numel(d)
    s1 = dir(d{i});
    size1 = s1.bytes;
    s2 = dir(d{i + 1});
    size2 = s2.bytes;
    
    if size1 > size2
        delete(d{i})
    else
        delete(d{i + 1})
    end
end

toc