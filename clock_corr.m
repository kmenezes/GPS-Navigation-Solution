function [delta_Tsv_P1,delta_Tsv_P2,delta_Tsv_C1]=clock_corr(SortedData, tkC1,tkP1,tkP2, delta_rel)
%Sources
%http://www.navipedia.net/index.php/Clock_Modelling
%http://www.navipedia.net/index.php/Relativistic_Clock_Correction
% Group Delay
tgd = 

a0 = SortedData(:,25); %SV clock bias or offset???
a1 = SortedData(:,26); %SV clock drift
a2 = SortedData(:,27); %SV clock drift rate

%Not sure about these time variables...
%Either clock data reference time (epoch time of obs)
%...or could be receiver time.
%...or could be the reference time in the header for the file?
%...in this case the receiver time is used for the sake of completion.
Toc_C1 = RcvrtC1;
Toc_P1 = RcvrtP1;
Toc_P2 = RcvrtP2;

%Not sure if using Nav GPS time or Obs GPS time.
%...in this case, using Nav GPS time for completion.
t = SortedData(:,26);

delta_Tsv_P1 = a0 + a1.*(t-Toc_C1)+a2.*(t-Toc_C1).^2+delta_rel;
delta_Tsv_P2 = a0 + a1.*(t-Toc_P1)+a2.*(t-Toc_P1).^2+delta_rel;
delta_Tsv_C1 = a0 + a1.*(t-Toc_P2)+a2.*(t-Toc_P2).^2+delta_rel;
end