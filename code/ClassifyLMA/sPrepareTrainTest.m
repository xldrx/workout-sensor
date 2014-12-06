% after extracting the features, you can use the featureCell in this script
% to prepare the train and test data

% divide data randomly into train and test sets
for i = [4,8,12,16,20,24,28,32,40,48]
% load(sprintf('../../FeatureExtraction/FeatureExtractor/mean%d.mat',i))
% load('data/mean12.mat')
% [train, test] = makeTrainTest(featureCell);

% slice the gestures win sliding window of size "windowSize" and moving steps
% "trainStepSz" for train data, and "testStepSz" for test data

windowSize  = 8;
trainStepSz = 8;
testStepSz  = 1;

winTrain = sliceGestures(train,windowSize,trainStepSz);
winTest  = sliceGestures(test,windowSize,testStepSz);

%% if you want to classify the weight, space, time
% convert the train and test data using the code below:
trainData = convertToWST(winTrain);
testData  = convertToWST(winTest);

% save(fullfile('data',sprintf('mean%d.mat',i)),'trainData','testData')
save(fullfile('data','sud.mat'),'trainData','testData')


end

%% if you want to classify the 8 BEAs
% comment the previous part and uncomment below:
% trainData = winTrain;
% testData  = winTest;


% you can save the data for future use
% save(fullfile('data','WSTdata.mat'),'trainData','testData')


