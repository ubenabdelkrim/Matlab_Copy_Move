function error = Copy_Move_Detection_KeyPoints(file)
White= [255,255,255];
I=imread(file);
file=file(1:end-4);
file=strcat(file,'_KeyPoint_duplicated.tif');

[r c n] = size(I);
m=zeros(r, c); % definint the image
b=255*ones(1); % definint the block

Igrey = rgb2gray(I); %converts the RGB image to grey image
points = detectSURFFeatures(Igrey);
[features_1, validPoints_1] = extractFeatures(Igrey,points);
[features_2, validPoints_2] = extractFeatures(Igrey,points);

indexPairsSURF = matchFeatures(features_1,features_2);
matchedSURF_1 = validPoints_1(indexPairsSURF(:,1));
matchedSURF_2 = validPoints_2(indexPairsSURF(:,2));

figure
showMatchedFeatures(Igrey,Igrey,matchedSURF_1, matchedSURF_2);

disp(matchedSURF_1.Location(2,2,1));


for i=1:size(matchedSURF_1,1)
    m(floor(matchedSURF_1.Location(i, 2, 1)), floor(matchedSURF_1.Location(i, 1, 1)))=b;
end
figure
imshow(m)
%% To Do
% This code has to be removed.
% It's only to show you how vlidPoints can be used

% End remove code
%% End To Do
imwrite(I,file);
end