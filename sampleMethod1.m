%% sampleMethod1
%   sampleMethod1 gather 25 faces into one group, with five overlapping
%   between two groups. it takes full combination within each group, then
%   take 70% of it. repeat the same set five times.
%

close all; clear all; clc;

%% ========== Part 1: parameter intialization ==========
load('genderList.mat');
feNum = sum(genderList ==0);
setSize = 25; % one set contains 25 different faces
overlapNum = 5; % two groups have 5 overlapping faces
nonOverNum = setSize-overlapNum;
repTimes = 5; % the same set repeat five times
groupNum = floor((feNum-setSize)/nonOverNum) + 1;% the total 953 faces are divided into #groupNum groups
totalNum = (groupNum-1) * nonOverNum + setSize; % abandom a few remaining one.

%% ========== Part 2: put 25 faces into one group ==========
groupID = zeros(groupNum, setSize);
groupID(1,:) = 1 : setSize;
for curGroup = 2 : groupNum
    groupID(curGroup, 1 : nonOverNum) = (1 + (curGroup-1)*nonOverNum) : curGroup*nonOverNum;
    randSeed = randperm(setSize,overlapNum);
    groupID(curGroup, nonOverNum+1:end) = groupID(curGroup-1, randSeed);
end

%% ========== Part 3: take full combinations within each group ==========
permArray = nchoosek(1:25,2);
fullCombNum = size(permArray, 1);
switchSeed = rands(fullCombNum, 1)>0;
temp = permArray;
permArray(switchSeed, 1) = temp(switchSeed, 2);
permArray(switchSeed, 2) = temp(switchSeed, 1);

%% ========== Part 4: take 70% from full combination ==========
ratio = 0.7;
subsetNum = round(fullCombNum*ratio);% 300*0.7=210
douArray = zeros(groupNum, subsetNum, 2);
for curGroup = 1 : groupNum
    curSeed = randperm(fullCombNum, subsetNum);
    temp2 = permArray(curSeed, :);%subsetNum * 2
    temp2 = reshape(temp2, [2*subsetNum, 1]);
    temp3 = groupID(curGroup, [temp2]);
    douArray(curGroup, :, :) = reshape(temp3, [subsetNum, 2]);
end

%% ========== Part 5: repeat each set five times ==========
douArray1 = repmat(douArray, [repTimes, 1, 1]);
save('sample1douArray.mat','douArray1'); % 235*210*2. #blocks, #trials #pair=2.

%% ========== Part 6: save sequence into txt format ==========
load('sample1DouArray.mat','douArray1');
groupNum = 47; repTimes = 5; subsetNum = 210;
douTemplate = zeros(subsetNum, 2);
for curR = 1 : repTimes%
    for curG = 1 : groupNum
        % read one set of trials
        startInd = (curR-1)*groupNum + curG;
        douTemplate = squeeze(douArray1(startInd, :, :));
        % write it into txt file
        douName = sprintf('../filesPublic/sampleMethod1/sampleMethod1_set%drep%d.txt',curG, curR);
        fid = fopen(douName, 'w');
        for curItr = 1 : subsetNum
            str = sprintf('F%d.jpg,F%d.jpg',douTemplate(curItr, 1), douTemplate(curItr, 2));
            fprintf(fid,'%s\n',str);
        end
        fclose(fid);
    end
end

