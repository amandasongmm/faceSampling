%% genFaceExamplePage.m
% generate collage of faces in the beginning of the experiment.

close all; 

% % same size as the padded image
% imH = 350; 
% imW = 270;
% figArray = zeros(imH*5, imW*5, 3, 'uint8');
% counter = 1; 
% for curFig = 1 : 3
%     for curHItr = 1 : 5
%         for curWItr = 1 : 5
%             nameStr = sprintf('../simi/static/images/2kFemale/F%d.jpg',counter);
%             k = imread(nameStr);
%             counter = counter + 1; 
%             figArray((curHItr-1)*imH+1:curHItr*imH, (curWItr-1)*imW+1:curWItr*imW, :) = k(1:imH, 1:imW, :);
%         end
%     end
%     nameStr = sprintf('../simi/static/images/faceExamples/femaleExp%d.jpg',curFig);
%     imwrite(figArray, nameStr, 'jpg');
% end

imH = 350; imW = 270; padding = 20; hRep = 5; wRep = 5; 
figH = imH * hRep + padding * (hRep-1);
paddingArray = zeros()

counter = 1; 
for curFig = 1 : 6
    h = figure; 
    for curSub = 1 : 16
        subplot(4, 4, curSub);
        nameStr = sprintf('../simi/static/images/2kFemale/F%d.jpg',counter);
        imshow(nameStr);
        counter = counter + 1;
    end
    saveStr = sprintf('../simi/static/images/faceExamples/femaleExp%d.jpg',curFig);
    saveas(h, saveStr);
end
