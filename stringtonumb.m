function [ val ] = stringtonumb( numb_sat )
% Converts String to number

number = str2double( numb_sat );
found_numb = number(not(isnan(number)));
r = length(found_numb);

val = 0;
for i = 1:r
    val = val + found_numb(i)*10^(r-i);
end

end

