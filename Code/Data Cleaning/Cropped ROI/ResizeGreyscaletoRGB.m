% NOT NEEDED since PyTorch ImageLoader converts single channel images to RGB!

d = dirPlus('J:\data (resized to 224 x 224 x 3, two classes, tif)');
for i = 1:numel(d)
    I = imread(d{i});
    I = imresize(I, [224, 224]);
    I = cat(3, I, I, I);
    imwrite(I, d{i});
end
