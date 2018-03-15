function [phi_k] = arg_lat(SortedData, Vk)
% w or omega = SortedData(:,42)
phi_k = Vk + SortedData(:,42);
end