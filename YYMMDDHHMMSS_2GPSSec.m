function [ TotalSeconds Weeks Seconds ] = YYMMDDHHMMSS_2GPSSec( Time )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if Time(1) < 70
    Time(1) = Time(1) + 2000;
elseif Time(1) > 70
    Time(1) = Time(1) + 1900
end

NonLeap =  [31 28 31 30 31 30 31 31 30 31 30 31];
Leapyear = [31 29 31 30 31 30 31 31 30 31 30 31];

days = 0;
if length(Time) == 6
    Sec_Time = Time(6)+Time(5)*60+Time(4)*3600;
    for i = 1980:Time(1)-1
        if isempty(find(1980:4:Time(1) == i))  
            daysTemp = sum(NonLeap);
        else
           daysTemp = sum(Leapyear); 
        end
        days = days+ daysTemp;
    end
    days = days-6;
    if isempty(find(1980:4:Time(1) == Time(1)))  
        daysTemp = sum(NonLeap(1:Time(2)-1));
    else
        daysTemp = sum(Leapyear(1:Time(2)-1));
    end
    days = days + daysTemp; 
    days = days + Time(3);
    weekDecimal = days/7;
    Weeks = floor(weekDecimal);
    Diff = weekDecimal - Weeks;
    SecondsInWeek = 7*24*60*60;
    Seconds = (weekDecimal-Weeks)*SecondsInWeek;
    Seconds = Seconds + Sec_Time;
    TotalSeconds = Seconds + Weeks*SecondsInWeek;
elseif length(Time) == 2
    

elseif length(Time) == 1
    
    
end

end

