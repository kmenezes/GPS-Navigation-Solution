function [delta_rel] = rel_corr(SortedData,Mk)
%Source: http://www.navipedia.net/index.php/Relativistic_Clock_Correction#cite_note-3
A = semi_major(SortedData);%semi-major axis
mu = 3.986005e14;  %grav const
c = physconst('LightSpeed');%speed of light
Ek = ecc_anom(SortedData,Mk);%eccentric anomaly
e = SortedData(:,33);%eccentricity

delta_rel = -2.*(sqrt(mu.*A)./(c^2)).*e.*sin(Ek);
end