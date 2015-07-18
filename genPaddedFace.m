%% genPaddedFace
%  This code generate face images with a specified background color and
%  cropped mask. 
%
%  Instructions
%  ------------
%  You may need to change the imgReadPath and/or imgSavePath as you see fit
%  Written by Amanda Song. Latest edited: 7/14/2015

%% ========== Part 1: load face files ===========
clc; clear; close all;
load('faceFilename.mat');% the original file names of 2222 faces
imgReadPath = '../simi/static/images/2kfaces_new/';
%imgSavePath = '../simi/static/images/2kFemale/';
imgSavePath = './image_background/';

% only take females.
load('genderList.mat');% 0: female, 1: male
feList = find(genderList==0);
feNum = length(feList);

%% ========== Part 2: specifiy parameters ==========
% pad height and width
padH = 350;
padW = 270;

% background color 
wheat = [245,222,179];
burlywood = [222,184,135];
tan = [210, 180, 140];
grayC = [128, 128, 128];
blackC = [0, 0, 0];
white = [255, 255, 255];
% specify background color
paddingColor = white;
%colorKeyword = {'burly','gray','black'};

%% ========== Part 3: cropping and padding ============
for curItr = 1 : 50%feNum
    curImInd = feList(curItr);
    fileName = faceFilename{curImInd};
    img = imread(sprintf('%s%s', imgReadPath, fileName));
    imshow(img);
    
    % crop faces with an elliptical mask
    h = imellipse(gca,[1,1,size(img,2)-1,size(img,1)-1]);
    BW = createMask(h);
    newImg = zeros(size(img),'uint8');
    [imH, imW, ~] = size(img);
    
    % color the background with specified paddingColor
    for i = 1 : 3
        band = img(:,:,i);
        newBand = paddingColor(i)*ones(imH, imW, 'uint8');
        newBand(BW) = band(BW);
        newImg(:,:,i)=newBand;
    end
    
    % rectify all image's height into 256
    if imH~=256
        imW = round(imW*256/imH);
        imH = 256;
        newImg = imresize(newImg,[imH,imW]);
    end
    
    % do the padding
    pArray = zeros(padH, padW+mod(imW, 2), 3, 'uint8'); %if even, unchange; if odd, +1.
    pArray(:,:,1) = padarray(newImg(:,:,1),[(padH-imH)/2, (padW+mod(imW,2)-imW)/2], paddingColor(1),'both');
    pArray(:,:,2) = padarray(newImg(:,:,2),[(padH-imH)/2, (padW+mod(imW,2)-imW)/2], paddingColor(2),'both');
    pArray(:,:,3) = padarray(newImg(:,:,3),[(padH-imH)/2, (padW+mod(imW,2)-imW)/2], paddingColor(3),'both');
    nameStr = sprintf('%sF%d.jpg', imgSavePath, curItr);
    imwrite(pArray, nameStr, 'jpg');
end

