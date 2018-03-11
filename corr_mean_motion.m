function [n] = corr_mean_motion(semi_maj, SortedData)
mu = 3.986005e14;
n0 = [sqrt(mu./(semi_maj.^3))];
n = n0 + SortedData(:,30);
end