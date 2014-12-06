function [LL, B, viterbi] = testHMM(testData, hmmParams, parallelFlag)

% inputs:
% testData:  cell of the test data in each class

% hmmParams: a struct of the trained parameters HMMs. The struct fields are
% cells, and each stores the parameters of one HMM

% for hmmParams use the trainHMM.m outputs.

%Use parallelFlag = 1 if you want to compute in parallel


% LL: one cell for each class, each cell contains the likelihood of the HMM using each test sequence
% B: one cell for each class, each member of the cell contains the B matrix (nState x nFrames) for the samples of each test data
% viterbi: one cell for each class, each member of the cell contains the viterbi vector (1 x nFrames) for the samples of each test data


addpath(genpath('../HMM_Murphy/'))
% using Kevin Murphy's HMM code for matlab

pr    = hmmParams.prior;
tr    = hmmParams.trans;
m     = hmmParams.mu;
s     = hmmParams.covar;
coeff = hmmParams.mixCoeff;

LL      = cell(1,length(testData));
B       = cell(1,length(testData));
viterbi = cell(1,length(testData));


% aggregating the classes
dataVec = [testData{:}];

if parallelFlag
    
    parfor i = 1:length(testData)
        params = structfun(@(x) x{i}, hmmParams, 'uni', 0);
        [LL{i}, B{i}, viterbi{i}] = test(dataVec, params, parallelFlag);
    end
           
else
    for i = 1:length(testData)
        params = structfun(@(x) x{i}, hmmParams, 'uni', 0);
        [LL{i}, B{i}, viterbi{i}] = test(dataVec, params, parallelFlag);
    end
end

% slicing the outputs to the number of samples in each class
len     = [0, cumsum(cellfun(@length, testData))];
LL      = cellfun(@(x) arrayfun(@(i,j) x(:,i+1:j), len(1:end-1), len(2:end), 'uni', 0), LL, 'uni', 0);
B       = cellfun(@(x) arrayfun(@(i,j) x(i+1:j), len(1:end-1), len(2:end), 'uni', 0), B, 'uni', 0);
viterbi = cellfun(@(x) arrayfun(@(i,j) x(i+1:j), len(1:end-1), len(2:end), 'uni', 0), viterbi, 'uni', 0);

end

function [LL, B, viterbi] = test(dataVec, params, parallelFlag)

pr    = params.prior;
tr    = params.trans;
m     = params.mu;
s     = params.covar;
coeff = params.mixCoeff;

LL      = zeros(1,length(dataVec));
B       = cell(1,length(dataVec));
viterbi = cell(1,length(dataVec));

if parallelFlag
    
    parfor i = 1:length(dataVec)
        % log likelihood
        LL(i) = mhmm_logprob(dataVec{i}, pr, tr, m, s, coeff);
        
        % matrix nState*nFrames of mix gaussian probability of sequence
        B{i} = mixgauss_prob(dataVec{i}, m, s, coeff);
        
        % viterbi path
        viterbi{i} = viterbi_path(pr, tr, B{i});
    end
            
else
    for i = 1:length(dataVec)
        % log likelihood
        LL(i) = mhmm_logprob(dataVec{i}, pr, tr, m, s, coeff);
        
        % matrix nState*nFrames of mix gaussian probability of sequence
        B{i} = mixgauss_prob(dataVec{i}, m, s, coeff);
        
        % viterbi path
        viterbi{i} = viterbi_path(pr, tr, B{i});
    end
end

        
end