clear;
clc;
tic

d = dirPlus('C:\Users\Apoorva\Desktop\small_set_balanced_CC\train', 'FileFilter', '\.png$'); % Added to MATLAB search path: https://www.mathworks.com/matlabcentral/fileexchange/60716-dirplus

for n = 1:numel(d)
    I = imread(d{n});
    [y, x, colors] = size(I);
    if x ~= 512 || y ~= 512 || colors ~= 1
        fprintf("%s\t%d\t%d\t%d\n", d{n}, x, y, colors)
    end
end

toc
