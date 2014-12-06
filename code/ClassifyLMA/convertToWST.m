function WST = convertToWST(BEA)
%% converting to WST and extracting features
wstIND{1} = [0 0 0 0 1 1 1 1];
wstIND{2} = [0 0 1 1 0 0 1 1];
wstIND{3} = [0 1 0 1 0 1 0 1];

% wstIND{1} = [0 0 1 1];
% wstIND{2} = [0 1 0 1];

WST = cellfun(@(ind) {BEA(ind == 0), BEA(ind == 1)}, wstIND, 'uni', 0);
WST = cellfun(@(x) cellfun(@(y) [y{:}], x, 'uni', 0), WST, 'uni', 0);

end