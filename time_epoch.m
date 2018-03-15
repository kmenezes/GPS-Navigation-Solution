function [tkP1, tkP2, tkC1, tt_P1, tt_P2, tt_C1] = time_epoch(SortedData)
%
% Time from ephemeris reference epoch
% tk = t -toe
% toe must account for beginning or end of week cross over
% see if statement(s)
% Input Sortadata
% Output Array of time in seconds
%

c = physconst('LightSpeed');

%travel time
tt_P1 = SortedData(:,6) - SortedData(:,11)./c;
tt_P2 = SortedData(:,6) - SortedData(:,12)./c;
tt_C1 = SortedData(:,6) - SortedData(:,13)./c;

%Time ephemeris reference epochs
tkP1 = check_tk(tt_P1 - SortedData(:,36));
tkP2 = check_tk(tt_P2 - SortedData(:,36));
tkC1 = check_tk(tt_C1 - SortedData(:,36));

end