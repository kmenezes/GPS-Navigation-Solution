%% Project Main
clear all;clc;close all;
format longg
%% Reading the Observation and Navigation Files

filename = 'ALGO0010.11N';
% filename = 'ALGO0010.08N';
% filename = 'alam3600.02n';
[ Nav_Out, IonAlpha, IonBeta, Delta_UTC, LS ] = Nav_Reader( filename );
% Output format
% Element          1         2     3    4     5        6        7         
% Obs_Out = [ObservationSet Year Month Day Time(DMS) GPSSec ClockOffset 
%   8   9  10 11 12 13 14 15 16 17 18
% GPSID L1 L2 P1 P2 C1 S1 S2 D1 D2 C2];
disp('Navigation File Processed')

filename = 'ALGO0010.11O';
% filename = 'ALGO0010.08O';
% filename = 'alam3600.02o';
[ Obs_Out, ApproxXYZ, obs_types  ] = ObsReader( filename );
% Output format
% Element       1    2     3    4     5      6        7         8  
% Nav_Out = [GPS_ID Year Month Day DecTime GPSSec ClockBias ClockDrift
%       9         10   11   12     13    14    15   16    17  18  19  
% ClockDriftRate Iode Crs DeltaN MoAngle Cuc Eccent Cus SqrtA Toe Cic 
%  20   21  22 23   24      25     26  27   28    29    30      31    
% OMEGA Cis Io Crc Omega OMEGADot IDot L2 GPSWeek L2P SVAccu SVHealth 
% 32   33     34         35
% TGD IODC TransTime FitInterval];
disp('Observation File Processed')

%% Combining and Storing necessary parameters

[ SortedData ] = NearestCombiner( Obs_Out, Nav_Out ); 
disp('Combined Navigation Data and Observation Data')

% %% Travel time for signal to get to receiver
% 
% [ C1tt P1tt P2tt ] = traveltime( SortedData );
% disp('Computed Travel time for signal to get to receiver')
%removed....


%% Compute A - semimajor axis [in m]

[A] = semi_major(SortedData);
disp('Computed A - semimajor axis')

%% Compute tk - Time from ephemeris reference epoch
% for some reason negative ?
[tkP1, tkP2, tkC1, tt_P1, tt_P2, tt_C1] = time_epoch(SortedData);
disp('Computed tk - Time from ephemeris reference epoch')

%% Rxcvr time in seconds

[RcvrtC1, RcvrtP1,RcvrtP2] = rcvrtime( SortedData, tt_C1, tt_P1, tt_P2 );
disp('Computed Rxcvr time in seconds')
%% Compute corrected mean motion [radians/s]
[n] = corr_mean_motion( A, SortedData);

%% Compute Mean anomoly
[Mk] = mean_anom(SortedData,n,tkC1);

%% Compute Eccentric Anomoly
[Ek] = ecc_anom(SortedData, Mk);

%% Relativistic Error
[delta_rel] = rel_corr(SortedData,Mk);

%% Clock Correction
[delta_Tsv_P1,delta_Tsv_P2,delta_Tsv_C1] = clock_corr(SortedData, tkC1,tkP1,...
    tkP2,RcvrtC1,RcvrtP1,RcvrtP2, delta_rel);

%% True Anomaly
[Vk] = true_anom(SortedData, Ek);

%% Argument of Latitude
[phi_k] = arg_lat(SortedData, Vk);

%% Second Harmonic Perturbations
% Argument of Latitude, Radius, and Inclination Correction, respectively.
[delta_uk,delta_rk,delta_ik] = sec_har_per(SortedData, phi_k);

%% Corrected Argument of Latitude
[Uk] = arg_lat_corr(phi_k, delta_uk);

%% Corrected Radius
[Rk] = rad_corr(SortedData, A, Ek, delta_rk);

%% Corrected Inclination
[IkC1, IkP1, IkP2] = inc_corr(SortedData, delta_ik, tkC1, tkP1, tkP2);

%% Positions in Orbital Plane
[Xk_op, Yk_op] = orb_plane(Rk, Uk);

%% Corrected Longitude of Ascending Node
[omega_kC1, omega_kP1, omega_kP2] = asc_node_corr(SortedData, tkC1,...
    tkP1, tkP2);

%% Earth-Fixed Coordinates
[XkC1, XkP1, XkP2, YkC1, YkP1, YkP2, ZkC1, ZkP1, ZkP2] =...
    e_fix_coor(IkC1, IkP1, IkP2, Xk_op, Yk_op, omega_kC1, omega_kP1, omega_kP2);
