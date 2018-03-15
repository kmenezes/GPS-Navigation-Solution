function [delta_uk,delta_rk,delta_ik] = sec_har_per(SortedData, phi_k)
% Argument of latitude correction [Cus = SortedData(:,34), Cuc =
% SortedData(:,32)]
delta_uk = SortedData(:,34).*sin(2.*phi_k)+SortedData(:,32).*cos(2.*phi_k);

% Radius Correction [Crs = SortedData(:,29), Crc = SortedData(:,41)]
delta_rk = SortedData(:,29).*sin(2.*phi_k)+SortedData(:,41).*cos(2.*phi_k);

% Inclination Correction [Cis = SortedData(:,39), Cic = SortedData(:,37)]
delta_ik = SortedData(:,39).*sin(2.*phi_k)+SortedData(:,37).*cos(2.*phi_k);
end