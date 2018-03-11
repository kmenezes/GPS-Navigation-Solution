function [RcvrtC1, RcvrtP1,RcvrtP2] = rcvrtime( SortedData, C1tt, P1tt, P2tt )
%rcvrtime This function computes the travel time to the receiver
%
% Receiver time in seconds = observation file time stamp in seconds - Travel time
% Inputs - from Obs_reader.m Obs_Out,
%   from traveltime.m C1tt, P1tt, P2tt
%
% Outputs - RcvrtC1, RcvrtP1,RcvrtP2 in seconds

RcvrtC1 = SortedData(:,6) - C1tt;
RcvrtP1 = SortedData(:,6) - P1tt;
RcvrtP2 = SortedData(:,6)- P2tt;

end
