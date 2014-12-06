function [prior, trans, mu, covar, mixCoeff] = initializeHMM(trainFeatures, initParams)
% using Kevin Murphy's HMM code in matlab

% number of hidden states
nStates      = initParams.nStates;

% number of gaussian mixtures
nMixtures    = initParams.nMixtures;

% use 1 if the architecture of HMM is left-right
if isfield(initParams,'LR')
    LRflag    = initParams.LR(1);
    LRmaxStep = initParams.LR(2);
else
    LRflag = 0;
end

% how to initialize state priors? 'rnd' -> random, 'uni' -> uniform
priorInit    = initParams.prior;

% how to initialize state transition matrix (A)? 'rnd' -> random, 'uni' -> uniform
transInit    = initParams.trans;

% how to initialize the gaussian mixtures coefficients? 'rnd' -> random, 'uni' -> uniform
mixtureInit  = initParams.mixtureInit;

% how to initialize the mean and variance of gaussians? 'rnd' -> random,
% 'kmeans' -> find the gaussian means by k-means algorithm and the use the variance
% of each k class
gaussCenterInit = initParams.gaussCenterInit;

% type of the gaussian covariance matrix, which can be 'diag' -> diagonal,
% 'sph' -> spherical, 'full' -> full
gaussCovType  = initParams.gaussCov;

nFeatures = size(trainFeatures{1},1);

rng('shuffle')

% initializing the prior probability of the states
if strcmp(priorInit,'rnd')
    prior = rand(nStates, 1);
else
    prior = ones(nStates, 1);
end

% normalize them to have sum = 1
prior = prior/sum(prior);

% initializing the state transition matrix
if strcmp(transInit,'rnd')
    trans = rand(nStates);
else
    trans = ones(nStates);
end

if LRflag
    trans = rand(nStates) .* full(spdiags(ones(nStates),0:LRmaxStep-1,nStates,nStates));
end

% normalizing the transition matrix to have sum = 1 on each row
trans = trans ./ repmat(sum(trans,2), [1, nStates]);



nanResult = 1;
counter   = 0;

while nanResult
    % initializing the mixture of gaussians parameters prior probability
    if strcmp(mixtureInit,'rnd')
        mixCoeff = rand(nStates, nMixtures);
    else
        mixCoeff = ones(nStates, nMixtures);
    end
    
    % normalizing
    mixCoeff = mixCoeff ./ repmat(sum(mixCoeff,2), [1, nMixtures]);
    
    % initializing the mixture of gaussians parameters
    [mu, covar] = mixgauss_init(nStates*nMixtures, cell2mat(trainFeatures), gaussCovType, gaussCenterInit);
    
    nanResult = any(any(any(isnan(covar))));
    
    if nanResult
        if counter == 10
            error('Cannot initialize the gaussians with k-means\n')
        else
            counter = counter + 1;
            fprintf('NAN Covariance\n')
        end
    end
end

mu    = reshape(mu, [nFeatures, nStates, nMixtures]);
covar = reshape(covar, [nFeatures, nFeatures, nStates, nMixtures]);

end