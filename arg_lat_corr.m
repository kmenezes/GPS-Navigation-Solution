function [delta_uk,delta_rk,delta_ik] = arg_lat_corr(SortedData, phi_k)
delta_uk = SortedData(:,34).*sin(2.*phi_k)+SortedData(:,32).*cos(2.*phi_k);
delta_rk = SortedData(:,29).*sin(2.*phi_k)+SortedData(:,41).*cos(2.*phi_k);
delta_ik = SortedData(:,39).*sin(2.*phi_k)+SortedData(:,37).*cos(2.*phi_k);
end