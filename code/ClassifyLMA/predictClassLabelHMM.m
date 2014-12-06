function [prLabel, probSeq] = predictClassLabelHMM(LL, B, viterbi, mode)
% input: use the outputs of testHMM
% mode:
% mode = 1: you want to predict the labels by comparing the likelihood of the whole sequence
% and the sequence probability by normalizing the log likelihood with the
% sum likelihood of the classes
% if for testing you use a sliding window with 1 step jumps, use this
% mode and it will give the predicted label (prLabel) of each time-frame
% and its probability (probSeq)

% mode = 2: you want to predict the labels and sequence probabilities using the viterbi path of
% each sequence and the corresponding mixGauss density of the
% features at the states identified by viterbi 
% if for test data you use a sliding window with no overlaps, use this mode

if mode == 1
    tempLL = reshape([LL{:}],length(LL),[])';
    tempLL = arrayfun(@(i) cell2mat(tempLL(:,i)), 1:length(LL{1}), 'uni', 0);
    [~, prLabel] = cellfun(@max, tempLL, 'uni', 0);
    probSeq = cellfun(@(x) 1 - x./(ones(size(x,1),1)*sum(x)), tempLL, 'uni', 0);
    
else
    
    probSeq = cellfun(@(b,v) cellfun(@(bTest,vTest) cellfun(@(bSamp,vSamp) arrayfun(@(i) bSamp(vSamp(i),i), 1:length(vSamp)), bTest, vTest, 'uni', 0), b, v, 'uni', 0), B, viterbi, 'uni', 0);
    probSeq = reshape([probSeq{:}],length(probSeq),[])';
    probSeq = arrayfun(@(i) probSeq(:,i), 1:size(probSeq,2), 'uni', 0);
    probSeq = cellfun(@(x) reshape(x, [], length(probSeq))', cellfun(@(y) [y{:}], probSeq, 'uni', 0), 'uni', 0);
    probSeq = cellfun(@(x) arrayfun(@(i) cell2mat(x(:,i)), 1:length(x), 'uni', 0), probSeq, 'uni', 0);
    [~, prLabel] = cellfun(@(x) cellfun(@(y) max(y), x, 'uni', 0), probSeq, 'uni', 0);
end

end