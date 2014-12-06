function prepTrainTest(featurePath, featureName, classifierType, winSz, trainStepSz, testStepSz)
load(fullfile(featurePath,sprintf('%s',featureName)))

% divide data randomly into train and test sets
[train, test] = makeTrainTest(featureCell);

% slice the gestures win sliding window of size "winSz" and moving steps
% "trainStepSz" for train data, and "testStepSz" for test data

winTrain = sliceGestures(train,winSz,trainStepSz);
winTest  = sliceGestures(test,winSz,testStepSz);

if classifierType == 1
% if you want to classify the weight, space, time
trainData = convertToWST(winTrain);
testData  = convertToWST(winTest);

else
% if you want to classify the 8 BEAs
trainData = winTrain;
testData  = winTest;

end

classifier = {'BEF','BEA'};

save(fullfile('data',sprintf('%s%s',classifier{classifierType},featureName)),'trainData','testData')

end


