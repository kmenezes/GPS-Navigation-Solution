function [Mk] = mean_anom(SortedData,n,tk)
Mk = SortedData(:,31) + n.*tk;
end
