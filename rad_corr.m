function [Rk] = rad_corr(SortedData, A, Ek, delta_rk)
%eccentricity
e = SortedData(:,33);

Rk = A.*(1-e.*cos(Ek)+delta_rk);

end