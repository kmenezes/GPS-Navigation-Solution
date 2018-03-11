function [ C1tt P1tt P2tt ] = traveltime( SortedData )
%traveltime - This function compuets the travel time of each
% pseudorange measurement
% Input from Obs_reader.m Obs_Out
% Output is an column vector of the travel times C1tt, P1tt, P2tt
% based on each observation

c = physconst('LightSpeed');

 P1tt = SortedData(:,11)./c;
 P2tt = SortedData(:,12)./c;
 C1tt = SortedData(:,13)./c;

end

