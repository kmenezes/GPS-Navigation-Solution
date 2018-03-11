function [tk] = time_epoch(SortedData)
tk = SortedData(:,52) - SortedData(:,36);
end