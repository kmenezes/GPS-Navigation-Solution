function [tk] = time_epoch(SortedData)
%
% Time from ephemeris reference epoch
% tk = t -toe
% toe must account for beginning or end of week cross over
% see if statement(s)
% Input Sortadata
% Output Array of time in seconds
%

tk = SortedData(:,52) - SortedData(:,36);
if(tk > 302400)
    tk = tk - 604800
if(tk < -302400)
    tk = tk + 604800
end
end