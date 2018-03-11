function [ lineOut ] = StandLength( lineIn )
% Standardizing Line Length for Easy Extraction

while length(lineIn) <80
   lineIn = [lineIn, ' '];
end

lineOut = lineIn;

end

