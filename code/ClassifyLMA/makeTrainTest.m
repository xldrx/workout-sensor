function [trainData, testData] = makeTrainTest(dataSet)
%% randomly select train and test data

% percent of data you want to use for training, the rest will be used for testing
trainPercent = 0.7;

rng('default')

idx      = cellfun(@(x) randperm(numel(x)), dataSet, 'uni', 0);
trainLen = cellfun(@(x) floor(trainPercent*numel(x)), dataSet, 'uni', 0);
trainIDX = cellfun(@(ind,len) ind(1:len), idx, trainLen, 'uni', 0);
testIDX  = cellfun(@(ind,len) ind(len+1:end), idx, trainLen, 'uni', 0);

trainData = cellfun(@(x,ind) x(ind), dataSet, trainIDX, 'uni',0);
testData  = cellfun(@(x,ind) x(ind), dataSet, testIDX, 'uni',0);
end