function hmmParams = trainHMM(trainData, initParams, nRepeatTrain, maxIteration, parallelFlag)
% using Kevin Murphy's HMM code for matlab
addpath(genpath('../HMM_Murphy/'))

% inputs:
% trainData: a cell that contains multiple cells for each class, and each class contains cells of training features
% initParams: use sTrainTestHMM.m
% nRepeatTrain: number of times that repeats training of each HMM and chooses the best model
% maxIteration: maximum number of training iterations for the HMMs
% parallelFlag: use 1 if you want to run in parallel


% outputs of trainHMM function is a struct that has the following fields:
% field LL contains cells of training Log Likelihood of HMM for each class
% field prior contains cells of prior vectors(nState x 1) of HMM for each class: state prior probability
% field trans contains cells of transition matrices (nState x nState) of HMM for each class
% field mu contains cells of gaussian means tensors (nFeatures x nStates x nMixtures) of HMM for each class
% field covar contains cells of gaussian covariance tensors (nFeatures x nFeatures x nStates x nMixtures) of HMM for each class
% field mixCoeff contains cells of gaussian mixture coefficient matrices (nStates x nMixtures) of HMM for each class

nClass = length(trainData);

% preallocating initial HMM parameters
prePrior    = cell(1,nRepeatTrain*nClass);
preTrans    = cell(1,nRepeatTrain*nClass);
preMu       = cell(1,nRepeatTrain*nClass);
preCovar    = cell(1,nRepeatTrain*nClass);
preMixCoeff = cell(1,nRepeatTrain*nClass);

% preallocating trained HMM parameters
trainLL      = cell(1,nRepeatTrain*nClass);
postPrior    = cell(1,nRepeatTrain*nClass);
postTrans    = cell(1,nRepeatTrain*nClass);
postMu       = cell(1,nRepeatTrain*nClass);
postCovar    = cell(1,nRepeatTrain*nClass);
postMixCoeff = cell(1,nRepeatTrain*nClass);


% we need to initialize and train the HMMs nRepeatTrain times for each
% class in training data. I vectorize the
% matrix(nRepeatTrain x nClass) of HMMs to a (nRepeatTrain*nClass x 1) 
% vector and with parfor train multiple HMMs in parallel

% the class index of each HMM in the vector
ind = reshape(ones(nRepeatTrain,1)*(1:nClass), 1, []);

% training will stop if the change in likelihood is less than thresh, or
% the maximum number of iterations is reached
threshold = 1e-16;

%% training
if parallelFlag
    
    parfor i = 1:length(ind)
        % use the train data of class ind(i) to initialize the HMM
        [prePrior{i},preTrans{i},preMu{i},preCovar{i},preMixCoeff{i}] = initializeHMM(trainData{ind(i)}, initParams);
    end
    parfor i = 1:length(ind)
    [trainLL{i}, postPrior{i},postTrans{i},postMu{i},postCovar{i},postMixCoeff{i}] = ...
        mhmm_em(trainData{ind(i)}, prePrior{i},preTrans{i},preMu{i},preCovar{i},preMixCoeff{i}, ...
        'max_iter', maxIteration, 'cov_type', initParams.gaussCov, 'thresh', threshold, 'verbose', 0);
    end

else
    for i = 1:length(ind)
        % outputs of initializeHMM function are:
        % prior(nState x 1): state prior probability
        % trans(nState x nState): transition matrix
        % mu(nFeatures x nStates x nMixtures): mean the gaussian mixes at each state
        % covar(nFeatures x nFeatures x nStates x nMixtures): covariance mtrix of the gaussian mixes at each state
        % mixCoeff(nStates x nMixtures): mixture coefficient for the gaussian mixes at each state
        
        % use the train data of class ind(i) to initialize the HMM
        [prePrior{i},preTrans{i},preMu{i},preCovar{i},preMixCoeff{i}] = initializeHMM(trainData{ind(i)}, initParams);
    end
    for i = 1:length(ind)
        [trainLL{i}, postPrior{i},postTrans{i},postMu{i},postCovar{i},postMixCoeff{i}] = ...
            mhmm_em(trainData{ind(i)}, prePrior{i},preTrans{i},preMu{i},preCovar{i},preMixCoeff{i}, ...
            'max_iter', maxIteration, 'cov_type', initParams.gaussCov, 'thresh', threshold, 'verbose', 0);
    end
end


%% preparing output
% identifying the best trained model by comparing the training Log Likelihood of
% last iteration of each training
[~,bestModelind] = arrayfun(@(i) max(arrayfun(@(j) trainLL{j}(end), i+(0:nRepeatTrain-1))), 1:nRepeatTrain:nRepeatTrain*nClass);

bestModelind = bestModelind + (0:nRepeatTrain:nRepeatTrain*nClass-1);

hmmParams.LL       = trainLL(bestModelind);
hmmParams.prior    = postPrior(bestModelind);
hmmParams.trans    = postTrans(bestModelind);
hmmParams.mu       = postMu(bestModelind);
hmmParams.covar    = postCovar(bestModelind);
hmmParams.mixCoeff = postMixCoeff(bestModelind);


end

    