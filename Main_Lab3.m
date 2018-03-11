%% Project Main
clear all;clc;close all;
format longg
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

%% Combining

[ SortedData ] = NearestCombiner( Obs_Out, Nav_Out ); 
disp('Combined Navigation Data and Observation Data')

%% Travel time

[ C1tt P1tt P2tt ] = traveltime( SortedData );

%% Rxcvr time

[RcvrtC1, RcvrtP1,RcvrtP2] = rcvrtime( SortedData, C1tt, P1tt, P2tt );