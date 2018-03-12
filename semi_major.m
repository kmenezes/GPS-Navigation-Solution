function [A] = semi_major(SortedData)
% Compute A - semimajor axis [in m]
A = SortedData(:,35).^2;
end