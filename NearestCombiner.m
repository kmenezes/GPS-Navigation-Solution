function [ SortedData ] = NearestCombiner( Obs_Out, Nav_Out )
% Combines two data file based on nearest Second

for i = 1:length(Obs_Out)
    % Looking line number for each Satellite that corresponds to the observation
    index{i,1} = find(Obs_Out(i,8) == Nav_Out(:,1));
    
    % Finds the min of the absolute value of (GPS-Sec - (GPS-Sat#), GPS-Sec) 
    [val, ind] = min(abs(Obs_Out(i,6) - Nav_Out(index{i,1}, 6)));
    
    % C
    index{i,2} = index{i,1}(ind);
    
    SortedData(i,:) = [Obs_Out(i,:) Nav_Out(index{i,2},:) ];
    
end   


end

