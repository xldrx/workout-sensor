%% PCA

meanFeatures = mean(cell2mat(allF{1}),2);
stdFeatures = std(cell2mat(allF{1}),[],2);

normalFeatures = bsxfun(@minus, cell2mat(allF{1}), meanFeatures);
normalFeatures = bsxfun(@rdivide, normalFeatures, stdFeatures);

covF = (normalFeatures*normalFeatures')/length(normalFeatures);

[U,S,V] = svd(covF);

wPCA = sqrtm(S)\U';

for i = 1:10
    subplot(5,2,i), bar(U(:,i))
end