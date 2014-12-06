function windowed = sliceGestures(data,winSz,stepSz)
% input: data has a cell for each class, and each cell contains the k data
% samples. It divides each sample into slices, using a sliding window of size
% winSz with steps of stepSz

    windowed = cellfun(@(x) cellfun(@(y) sliceData(y,winSz,stepSz), x, 'uni', 0), data, 'uni', 0);
    windowed = cellfun(@(x) [x{:}], windowed, 'uni', 0);
end

function sliced = sliceData(data,winSz,stepSz)
    idx    = 1:stepSz:size(data,2)-winSz+stepSz-2;
    len    = size(data,2);
    sliced = arrayfun(@(i) data(:,i:min(i+winSz-1,len)), idx, 'uni', 0);
end