% Names
%{
dinfo = dir();
dinfo(ismember( {dinfo.name}, {'.', '..'})) = [];  %remove . and ..
subfolders = dinfo([dinfo.isdir]);      % logical array indexing

test = 'I:\Project Data\FinalData\normal\LEFT_MLO (695)';

for i = 1:length(subfolders)
   subfolder = subfolders(i).name;
   if ~isequal(subfolder, test)
       
   end
end
%}
clc;
clear;

folder_1 = 'I:\Project Data\FinalData\abnormal\cancer (label to be merged into abnormal)\LEFT_CC\*.png';
folder_2 = 'I:\Project Data\FinalData\abnormal\cancer (label to be merged into abnormal)\LEFT_MLO\*.png';
folder_3 = 'I:\Project Data\FinalData\abnormal\cancer (label to be merged into abnormal)\RIGHT_CC (one less PMG than the rest!)\*.png';
folder_4 = 'I:\Project Data\FinalData\abnormal\cancer (label to be merged into abnormal)\RIGHT_MLO\*.png';

files_1 = dirPlus(folder_1, 'PrependPath', false); % Used dirPlus to get a cell array instead of a struct from dir
files_2 = dirPlus(folder_2, 'PrependPath', false);
files_3 = dirPlus(folder_3, 'PrependPath', false);
files_4 = dirPlus(folder_4, 'PrependPath', false);

count = 0;
for i = 1:numel(files_1)
    [~, name, ext] = fileparts(files_1{i});
    name_ext = strcat(name, ext);
    
    check_1 = ~any(strcmp(files_2, name_ext));
    check_2 = ~any(strcmp(files_3, name_ext));
    check_3 = ~any(strcmp(files_4, name_ext));
    
    if check_1 || check_2 || check_3
        count = count + 1;
        disp(name_ext);
        if check_1
            disp(folder_2)
        end
        if check_2
            disp(folder_3)
        end
        if check_3
            disp(folder_4)
        end
        fprintf('\n');
    end
end
