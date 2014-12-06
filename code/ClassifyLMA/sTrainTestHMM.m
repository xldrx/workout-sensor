%% use this script to classify BEF, or BEA

% first extract features using sPrepareAllFeatures.m in FeatureExtraction
% folder, then prepare train/test data using sPrepareTrainTest.m in this
% folder, and finally make modifications in this script and run

%% preparing the HMM parameters

% use 1 if you want to parallelize this process (you should have the
% matlab parallel toolbox)
parallelFlag = 1;

% number of hidden states
initParams.nStates = 8;

% number of gaussian mixtures
initParams.nMixtures = 2;

% use 1 if the architecture of HMM is left-right, otherwise 0
LRflag = 0;
% put the maximum number of allowed jump between
% states. This number should be grater than 0, and less or equal to number
% of states
maxJump = 3;

initParams.LR = [LRflag maxJump];

% how to initialize state priors? 'rnd' -> random, 'uni' -> uniform
initParams.prior = 'rnd';

% how to initialize state transition matrix (A)? 'rnd' -> random, 'uni' -> uniform
initParams.trans = 'rnd';

% how to initialize the gaussian mixtures coefficients? 'rnd' -> random, 'uni' -> uniform
initParams.mixtureInit = 'rnd';

% how to initialize the mean and variance of gaussians? 'rnd' -> random,
% 'kmeans' -> find the gaussian means by k-means algorithm and the use the variance
% of each k class
initParams.gaussCenterInit = 'kmeans';

% type of the gaussian covariance matrix, which can be 'diag' -> diagonal,
% 'sph' -> spherical, 'full' -> full
initParams.gaussCov = 'diag';

% number of times you want to train each model. It chooses the model with
% highest log likelihood
nRepeatTrain = 5;

% maximum number of training iterations. This number depends on the number of
% training data and parameters (states, mix gaussians)
maxIteration = 200;

% classifierMode = 1: if for testing you use a sliding window with 1 step jumps, use this
% mode and the classifier will predict one label for each test sequence
% classifierMode = 2: if for testing you use a sliding window with step size equal to window size, use this
% mode and the classifier will predict a label for each frame of the test
% sequence by computing the most likely state sequence and the mixGauss
% density of the frame for its hidden state
classifierMode = 1;





%% classifying BEF:
% make sure your train/tast data has the same architecture as the output of
% convertToWST

% classifyBEF uses the same architecture for trainFeatures as it is used in
% feature extraction script:
% { {class1{..sample1-of-class1..},{..sample2-of-class1..},...} , {class2{...},{...},...} , {class3...} , ... }
% the rest of parameters should be set in the script
% the trained HMM parameters and test result will be saved with this name:
testName = 'BEF1';


% (you can find detailed description of this output in the related functions)
% hmmBEF is a struct with fields: 
% hmmParams: is a struct with fields that are cell and each cell contains the HMM parameters for one class
% the rest of the fields are cell 1x3 that contain the test results for
% each 3 classifier (weight, space, time). Each of these cells have two
% cells or array with 2 columns that contain the value of that field using
% the HMM for indulging/fighting quality
% LL: log likelihood of each test sample
% B: gaussian mix density for each state at each frame
% viterbi: viterbi path of each sample
% prLabel: predicted label of the sequences. depending on the 'classifierMode' you use, it can be one label for entire sequence or one label per each frame of sequence
% probSeq: contains the probability of sequence/frames depending on 'classifierMode'
% conf: confusion matrix of each classification
% precison: precison of each classification
% recall: recall rate of each classification
% F1: F1 score of each classification

hmmBEF = classifyBEF(trainData, testData, initParams, nRepeatTrain, maxIteration, parallelFlag, classifierMode, testName);





%% classifying BEA:
% do not use convertToWST on the features

% same outputs as BEF, but the test results are in a single cell, not 3
% differen cells

% the trained HMM parameters and test result will be saved with this name:
% testName = 'BEA1';
% 
% hmmBEA = classifyBEA(trainData, testData, initParams, nRepeatTrain, maxIteration, parallelFlag, classifierMode, testName);
























