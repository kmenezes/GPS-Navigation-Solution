function [Ek] = ecc_anom(SortedData, Mk)
% This function uses Newton’s method to solve Kepler’s
% equation E - e*sin(E) = M for the eccentric anomaly,
% given the eccentricity and the mean anomaly.
% Output E - eccentric anomaly (radians)
% Input SoredData(:,33) e - eccentricity, passed from the calling program
% Input Mk - mean anomaly (radians), passed from the calling program
% pi - 3.1415926...

%...Set an error tolerance:
error = 1.e-12;
% e - eccentricity
e = SortedData(:,33);
%...Select a starting value for E:
if Mk < pi
Ek = Mk + e./2;
else
Ek = Mk - e./2;
end
%...Iterate on Equation until E is determined to within
%...the error tolerance:
ratio = 1;
while abs(ratio) > error
ratio = (Ek - e.*sin(Ek) - Mk)./(1 - e.*cos(Ek));
Ek = Ek - ratio;
end
end 