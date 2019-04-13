clear; clc;
tic

d = dirPlus('J:\data (augmented, 2 classes, tif)\train');
sum_ = 0;
count = 0;
for i = 1:numel(d)
    %disp(i);
    I = double(imread(d{i}));
    I = I(:, :, 1);
    %disp(mean2(I));
    sum_ = sum_ + sum(sum(I));
    count = count + numel(I);
end

disp(sum_/count);
toc

%{
% ALITER (if all have the same size!)

M = uint8(zeros(224, 224, 3, 2291));
for i = 1:numel(d)
    disp(i);
    M(:, :, :, i) = imread(d{i});
    end
mean(M, 'all')
std(double(M), 0, 'all')
%}