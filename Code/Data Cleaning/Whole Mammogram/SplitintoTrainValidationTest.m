clc; clear;

d = dirPlus('I:\Project Data\FINAL Data (512 x 512 x 2)');  % gives only files, not subfolders!
training = 'I:\Project Data\FINAL Data (512 x 512 x 2)\training';
validation = 'I:\Project Data\FINAL Data (512 x 512 x 2)\validation';
test = 'I:\Project Data\FINAL Data (512 x 512 x 2)\test';

if rem(numel(d), 2)
    msg = 'This code works only if numel(d) is even! Either make d have an even number of files or modify the code!';
    error(msg);
end

% QUESTION: What if all the, say, benigns are first and hence they go into training only?
for i = 1:floor(0.6*numel(d))     % MATLAB includes the endpoint also! BC! The first index should be odd (LEFT) and the second should be even (RIGHT) since MATLAB indexing is one-based!
    disp(i);
    movefile(d{i}, training);
end

for i = ceil(0.6*numel(d)):ceil(0.8*numel(d))     % MATLAB includes the endpoint also! BC!
    disp(i);
    movefile(d{i}, validation);
end

for i = (ceil(0.8*numel(d)) + 1):numel(d)     % MATLAB includes the endpoint also! BC!
    disp(i);
    movefile(d{i}, test);
end
