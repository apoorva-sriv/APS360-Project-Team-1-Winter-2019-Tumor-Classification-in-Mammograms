clear;
clc;
tic

fileID = fopen('C:\Users\Apoorva\Desktop\TO DO.txt', 'r');

count = 0;
while ~feof(fileID)
    line = fgetl(fileID);
    line = strip(line, '"');
    I = imread(line);          
    imwrite(fliplr(I), line);
    count = count + 1
end

fclose(fileID);

toc