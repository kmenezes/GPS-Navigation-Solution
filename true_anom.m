function [Vk] = true_anom(SortedData, Ek)
% https://stackoverflow.com/questions/35877176/
% finding-true-anomaly-without-ambiguity
% Compute True Anomaly Components
e = SortedData(:,33)
% S = (sqrt(1 - e.^2).*sin(Ek)) ./ (1 - e.*cos(Ek));
% C = (cos(Ek) - e) ./ (1 - e.*cos(Ek));
% val = C + 1i.*S;
% Vk = atan2(S,C);

Vk = 2*atan(sqrt((1+e)./(1-e)).*tan(Ek./2));
if(Vk<0)
    Vk=Vk+2*pi;
end
    
end
