function hmmBEA = classifyBEA(trainData, testData, initParams, nRepeatTrain, maxIteration, parallelFlag, classifierMode, testName)
% classifying weight, space, time

if parallelFlag
    % check if matlabpool is not already open
    if ~matlabpool('size')
        % open the matlabpool
        matlabpool OPEN
    end
end


%% training

% classifyBEF uses the same architecture for trainFeatures as it is used in
% feature extraction script:
% { {class1{..sample1-of-class1..},{..sample2-of-class1..},...} , {class2{...},{...},...} , {class3...} , ... }
% the rest of parameters should be set in the sTrainTestHMM script
hmmParams = trainHMM(trainData, initParams, nRepeatTrain, maxIteration, parallelFlag);

%% testing

    [LL, B, viterbi] = testHMM(testData, hmmParams, parallelFlag);
    [prLabel, probSeq] = predictClassLabelHMM(LL, B, viterbi, classifierMode);
    [conf, precision, recall, F1] = computeStat(prLabel);

% close the matlabpool
matlabpool CLOSE

%% preparing output

hmmBEA = struct();

hmmBEA.hmmParams = hmmParams;
hmmBEA.LL      = LL;
hmmBEA.B       = B;
hmmBEA.viterbi = viterbi;
hmmBEA.prLabel = prLabel;
hmmBEA.probSeq = probSeq;
hmmBEA.conf    = conf; % confusion matrix
hmmBEA.precision = precision;
hmmBEA.recall  = recall;
hmmBEA.F1      = F1;

save(sprintf('%s.mat',testName), 'hmmBEA')

end
