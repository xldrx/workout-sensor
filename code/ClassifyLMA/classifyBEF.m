function hmmBEF = classifyBEF(trainData, testData, initParams, nRepeatTrain, maxIteration, parallelFlag, classifierMode, testName)
% classifying weight, space, time

if parallelFlag
    % check if matlabpool is not already open
    if ~matlabpool('size')
        % open the matlabpool
        matlabpool OPEN
    end
end


%% training

trainFeatures = [trainData{:}];

% classifyBEF uses the same architecture for trainFeatures as it is used in
% feature extraction script:
% { {class1{..sample1-of-class1..},{..sample2-of-class1..},...} , {class2{...},{...},...} , {class3...} , ... }
% the rest of parameters should be set in the sTrainTestHMM script
hmmParams = trainHMM(trainFeatures, initParams, nRepeatTrain, maxIteration, parallelFlag);

%% testing

LL      = cell(1,3);
B       = cell(1,3);
viterbi = cell(1,3);
prLabel = cell(1,3);
probSeq = cell(1,3);
conf    = cell(1,3); % confusion matrix
precision = cell(1,3);
recall  = cell(1,3);
F1      = cell(1,3);
tpr     = cell(1,3);
fpr     = cell(1,3);

lbl = {[1 0],[0 1]};

for i = 1:3
    params = structfun(@(x) x(i*2-1:i*2), hmmParams, 'uni', 0);
    [LL{i}, B{i}, viterbi{i}] = testHMM(testData{i}, params, parallelFlag);
    [prLabel{i}, probSeq{i}] = predictClassLabelHMM(LL{i}, B{i}, viterbi{i}, classifierMode);
    [conf{i}, precision{i}, recall{i}, F1{i}] = computeStat(prLabel{i});
    labels = cell2mat(cellfun(@(x,l) repmat(l, length(x), 1), probSeq{i}, lbl, 'uni', 0)');
    [tpr{i},fpr{i},~] = roc(labels',cell2mat(cellfun(@(x) x', probSeq{i}, 'uni', 0)')');
end

% close the matlabpool
matlabpool CLOSE





%% preparing output

hmmBEF = struct();

hmmBEF.hmmParams = hmmParams;
hmmBEF.LL      = LL;
hmmBEF.B       = B;
hmmBEF.viterbi = viterbi;
hmmBEF.prLabel = prLabel;
hmmBEF.probSeq = probSeq;
hmmBEF.conf    = conf; % confusion matrix
hmmBEF.precision = precision;
hmmBEF.recall  = recall;
hmmBEF.F1      = F1;
hmmBEF.tpr     = tpr;
hmmBEF.fpr     = fpr;

save(sprintf('%s.mat',testName), 'hmmBEF')

end
