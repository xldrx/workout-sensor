function [] = fLoadTrim(dataPath,fileName)


dirData   = dir(fullfile(dataPath,'*.csv'));
dataNames = {dirData.name};

dataTable = cellfun(@(x) readtable(fullfile(dataPath,x)), dataNames, 'uni', 0);

features = cellfun(@(x) x{:,[12:19, 21:32]}', dataTable, 'uni', 0);

% x = cell(1,length(features));
% 
% for i = 1:length(features)
%     figure(1), clf, hold on
%     plot(features{i}(1:3,:)')
%     [xTemp,~,~] = ginput(2);
%     x{i} = floor(xTemp);
% end

% featuresClean = cellfun(@(dt,ind) dt(:,ind(1):ind(2)), features, x, 'uni', 0);

 save(fullfile(dataPath,fileName), 'features')