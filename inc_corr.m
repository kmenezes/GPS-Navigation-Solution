function [IkC1, IkP1, IkP2] = inc_corr(SortedData, delta_ik, tkC1, tkP1, tkP2)
i0 = SortedData(:,40);
iDOT = SortedData(:,44);
IkC1 = i0 + delta_ik + iDOT.*tkC1;
IkP1 = i0 + delta_ik + iDOT.*tkP1;
IkP2 = i0 + delta_ik + iDOT.*tkP2;
end