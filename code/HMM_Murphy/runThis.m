addpath(genpath('../HMM_Murphy'))

load velocity_0_16_crf_test
testF = cell2mat(featuresStruct.features);
testL = cell2mat(featuresStruct.effortLabels);
testL(testL == 9) = 2;

load velocity_0_16_crf_train
trainF = cell2mat(featuresStruct.features);
trainL = cell2mat(featuresStruct.effortLabels);
trainL(trainL == 9) = 2;


%%   test for time

sustainedClass = trainF(:,trainL(3,:) == 0);
suddenClass    = trainF(:,trainL(3,:) == 1);
neutralClass   = trainF(:,trainL(3,:) == 2);

O = size(trainF,1); % number of features
M = 2; % each frame of the features is mixture of 5 gaussians
Q = 4; % each class has 10 hidden states

minLength = min([length(sustainedClass) length(suddenClass) length(neutralClass)]);
nFramesPerSeq = floor(minLength/15);

nexSus  = floor(length(sustainedClass)/nFramesPerSeq); % number of training sequences
nexSud  = floor(length(suddenClass)/nFramesPerSeq);
nexNeut = floor(length(neutralClass)/nFramesPerSeq);

maxIteration = 15;

nFramesSus  = nFramesPerSeq;
nFramesSud  = nFramesPerSeq;
nFramesNeut = nFramesPerSeq;

sustainedClass = reshape(sustainedClass(:,1:nexSus*nFramesSus), [int16(O) int16(nFramesSus) int16(nexSus)]);
suddenClass    = reshape(suddenClass(:,1:nexSud*nFramesSud), [O nFramesSud nexSud]);
neutralClass   = reshape(neutralClass(:,1:nexNeut*nFramesNeut), [O nFramesNeut nexNeut]);



prior0 = normalise(rand(Q,1));
transmat0 = mk_stochastic(rand(Q,Q));

%%   sustained class training:

T   = nFramesSus; % length of train sequences
nex = nexSus; % number of training sequences

[mu0, Sigma0] = mixgauss_init(Q*M, reshape(sustainedClass, [O T*nex]), 'full'); % full covariance
mu0 = reshape(mu0, [O Q M]);
Sigma0 = reshape(Sigma0, [O O Q M]);
mixmat0 = mk_stochastic(rand(Q,M));

[LLSus, priorSus, transmatSus, muSus, SigmaSus, mixmatSus] = ...
    mhmm_em(sustainedClass, prior0, transmat0, mu0, Sigma0, mixmat0, 'max_iter', maxIteration);

%%   sudden class training:

T   = nFramesSud; % length of train sequences
nex = nexSud; % number of training sequences

[mu0, Sigma0] = mixgauss_init(Q*M, reshape(suddenClass, [O T*nex]), 'full'); % full covariance
mu0 = reshape(mu0, [O Q M]);
Sigma0 = reshape(Sigma0, [O O Q M]);
mixmat0 = mk_stochastic(rand(Q,M));

[LLSud, priorSud, transmatSud, muSud, SigmaSud, mixmatSud] = ...
    mhmm_em(suddenClass, prior0, transmat0, mu0, Sigma0, mixmat0, 'max_iter', maxIteration);

%%   neutral class training:

T   = nFramesNeut; % length of train sequences
nex = nexNeut; % number of training sequences

[mu0, Sigma0] = mixgauss_init(Q*M, reshape(neutralClass, [O T*nex]), 'full'); % full covariance
mu0 = reshape(mu0, [O Q M]);
Sigma0 = reshape(Sigma0, [O O Q M]);
mixmat0 = mk_stochastic(rand(Q,M));

[LLNeut, priorNeut, transmatNeut, muNeut, SigmaNeut, mixmatNeut] = ...
    mhmm_em(neutralClass, prior0, transmat0, mu0, Sigma0, mixmat0, 'max_iter', maxIteration);

%%  Testing the classifier

windowSize = 9;
halfW = floor(windowSize/2);

loglikSus  = zeros(1,length(testF));
loglikSud  = zeros(1,length(testF));
loglikNeut = zeros(1,length(testF));

for i = halfW+1:length(testF)-halfW
    loglikSus(i)  = mhmm_logprob(testF(:,i-halfW:i+halfW), priorSus, transmatSus, muSus, SigmaSus, mixmatSus);
    loglikSud(i)  = mhmm_logprob(testF(:,i-halfW:i+halfW), priorSud, transmatSud, muSud, SigmaSud, mixmatSud);
    loglikNeut(i) = mhmm_logprob(testF(:,i-halfW:i+halfW), priorNeut, transmatNeut, muNeut, SigmaNeut, mixmatNeut);
end

[~, maxLL] = max([loglikSus; loglikSud; loglikNeut]);
maxLL = maxLL - 1;


featureToPlot = 1;
featureToPlotName = 'X-Velocity';
testFor = 'time';

if strcmp(testFor,'time')
    qualityLabel = 3;
end

% if ~strcmp(testFor, 'gesture')
%     for i = 1:numel(testF)
        featureVals = testF(featureToPlot, :);
        featureVals = featureVals/max(abs(featureVals))*2;
        featureVals(end+1) = featureVals(end);
%         figure(i)
        hold off; hold on
        featureColor = 'rgb';
        predictColor = {'c--','k-.','m:'};
        lt1 = [0 0 0];
        lt2 = [0 0 0];
        
        for lbl = 0:2
            maskF = padarray(int8(testL(qualityLabel,:) == lbl),[0,1],0);
            posF  = find(maskF(2:end) - maskF(1:end-1));
            for m = 1:2:numel(posF)
                lt1(lbl+1) = plot(posF(m):posF(m+1), featureVals(posF(m):posF(m+1)), featureColor(lbl+1), 'LineWidth', 1);
            end
            
            maskLL = padarray(int8(maxLL == lbl),[0,1], 0);
            posLL  = find(maskLL(2:end) - maskLL(1:end-1));
            
            for m = 1:2:numel(posLL)
                lt2(lbl+1) = plot(posLL(m):posLL(m+1)-1, maxLL(posLL(m):posLL(m+1)-1), featureColor(lbl+1), 'LineWidth', 1);
            end
            
        end
        
        axis([0 length(testL) min(featureVals)-0.1 2.1])
        
        legend([lt1(1),lt1(2),lt1(3),lt2(1),lt2(2),lt2(3)], ...
            {sprintf('%s with %s = 0', featureToPlotName, testFor), sprintf('%s with %s = 1', featureToPlotName, testFor), ...
            'neutral', sprintf('p(%s = 0)', testFor), sprintf('%s = 1', testFor), ...
            'neutral'})
        
        title(sprintf('%s and predicted label for %s quality',featureToPlotName, testFor))
        ylabel(sprintf('most likely class'))
        xlabel('frames')
%     end
% end




