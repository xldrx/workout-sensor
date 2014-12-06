function runClassifier(nameID, classifierType)

parallelFlag = 1;

initParams.nStates = 8;

initParams.nMixtures = 2;

LRflag = 0;

maxJump = 3;

initParams.LR = [LRflag maxJump];

initParams.prior = 'rnd';

initParams.trans = 'rnd';

initParams.mixtureInit = 'rnd';

initParams.gaussCenterInit = 'kmeans';

initParams.gaussCov = 'diag';

nRepeatTrain = 5;

maxIteration = 200;

classifierMode = 1;

load('nameIDs.mat');
name = fileName{classifierType}{nameID};

load(fullfile('data',name))

if classifierType == 1
    
    hmmBEF = classifyBEF(trainData, testData, initParams, nRepeatTrain, maxIteration, parallelFlag, classifierMode, name(1:end-4));
    
else
    
    hmmBEA = classifyBEA(trainData, testData, initParams, nRepeatTrain, maxIteration, parallelFlag, classifierMode, name(1:end-4));
    
end

end




















