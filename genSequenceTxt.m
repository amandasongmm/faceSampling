% convert2string. convert the index array into a filename string.

%% transfer from doublet.mat to txt file.
femaleList = find(genderList == 0);
feNum = length(femaleList);
fid = fopen('feDou.txt','w');
sampleStim = zeros(200, 2);
for curItr = 1 : 200
    sampleStim(curItr, :) = randperm(feNum, 2);
    str = sprintf('F%d.jpg,F%d.jpg',sampleStim(curItr,1),sampleStim(curItr,2));
    fprintf(fid,'%s\n',str);
end

