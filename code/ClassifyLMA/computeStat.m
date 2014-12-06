function [conf, pr, rc, f1] = computeStat(prLabels)

    actLbls = arrayfun(@(i) i*ones(1,numel(prLabels{i})), 1:numel(prLabels), 'uni', 0);

    [conf, pr, rc, f1] = computeStats(actLbls, prLabels);

end


function [conf, precision, recall, f1] = computeStats(actLabel, prLabel)
    nLabel = numel(actLabel);

    actLabel = [actLabel{:}];
    prLabel  = [prLabel{:}];

    prClass  = zeros(nLabel, numel(prLabel));
    actClass = zeros(nLabel, numel(prLabel));

    for i = 1:nLabel
        prClass(i,:)  = prLabel == i;
        actClass(i,:) = actLabel == i;
    end

    [~, conf] = confusion(actClass, prClass);
    precision = arrayfun(@(i) conf(i,i)/sum(conf(:,i)), 1:nLabel);
    recall    = arrayfun(@(i) conf(i,i)/sum(conf(i,:)), 1:nLabel);
    f1        = arrayfun(@(x,y) 2*x*y/(x+y), precision, recall);
end