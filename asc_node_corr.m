function [omega_kC1, omega_kP1, omega_kP2] = asc_node_corr(SortedData, tkC1,...
    tkP1, tkP2)
% Source
% https://astronomy.stackexchange.com/questions/5887/derivation-of-the-formula-for-longitude-of-ascending-node-for-a-satellite
% http://ccar.colorado.edu/asen5050/projects/projects_2008/xiaofanli/

omega_0 = SortedData(:,38);
omega_DOT = SortedData(:,43);
toe = SortedData(:,36);

%WGS-84 value of the Earth's rotation rate [rad/s]
omega_DOT_e = 7.2921151467e-5;

omega_kC1 = omega_0 + ((omega_DOT-omega_DOT_e).*tkC1)-omega_DOT_e.*toe;
omega_kP1 = omega_0 + ((omega_DOT-omega_DOT_e).*tkP1)-omega_DOT_e.*toe;
omega_kP2 = omega_0 + ((omega_DOT-omega_DOT_e).*tkP2)-omega_DOT_e.*toe;
end