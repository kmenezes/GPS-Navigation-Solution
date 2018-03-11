function [ Nav_Out, IonAlpha, IonBeta, Delta_UTC, LS ] = Nav_Reader( filename )
fid = fopen(filename);
line = fgetl(fid);
IonAlpha = NaN;
IonBeta = NaN;
Delta_UTC = NaN;
LS = NaN;
% Collecting Header info
while isequal(strfind(line, 'END OF HEADER'), [])
    if strfind(line, 'ION ALPHA')
        IA1 = str2double(line(1:10)) * 10^(str2double(line(12:14)));
        A2 = str2double(line(15:22)) * 10^(str2double(line(24:26)));
        A3 = str2double(line(27:34)) * 10^(str2double(line(36:38)));
        A4 = str2double(line(39:46)) * 10^(str2double(line(48:50)));
        IonAlpha = [IA1 A2 A3 A4];
    elseif strfind(line, 'ION BETA')
        B1 = str2double(line(1:10)) * 10^(str2double(line(12:14)));
        B2 = str2double(line(15:22)) * 10^(str2double(line(24:26)));
        B3 = str2double(line(27:34)) * 10^(str2double(line(36:38)));
        B4 = str2double(line(39:46)) * 10^(str2double(line(48:50)));
        IonBeta = [B1 B2 B3 B4];
    elseif strfind(line, 'DELTA-UTC: A0,A1,T,W')
        A0 = str2double(line(1:18)) * 10^(str2double(line(20:22)));
        A1 = str2double(line(23:37)) * 10^(str2double(line(39:41)));
        T = str2double(line(42:50)); 
        W = str2double(line(51:59));
        Delta_UTC = [A0 A1 T W];
    elseif strfind(line, 'LEAP SECONDS')
        LS = str2double(line(1:6));
    end
    line = fgetl(fid); % Opening Next Line
end

% Collecting data on orbit
Nav_Out = [];
line = fgetl(fid);
i = 1;
while ischar(line)
    line2 = fgetl(fid);
    line3 = fgetl(fid);
    line4 = fgetl(fid);
    line5 = fgetl(fid);
    line6 = fgetl(fid);
    line7 = fgetl(fid);
    line8 = fgetl(fid);
    
    GPS_ID = str2double(line(1:2));
    time = str2double(strsplit(line(4:22)));
    [Time Weeks Seconds] = YYMMDDHHMMSS_2GPSSec( time );
    Time = [time(1:3) dms2degrees(time(4:6)) Time];
    ClockBias = str2double(line(23:37)) * 10^(str2double(line(39:41)));
    ClockDrift = str2double(line(42:56)) * 10^(str2double(line(58:60)));
    ClockDriftRate = str2double(line(61:75)) * 10^(str2double(line(77:79)));
    
    Iode = str2double(line2(4:18)) * 10^(str2double(line2(20:22)));
    Crs = str2double(line2(23:37)) * 10^(str2double(line2(39:41)));
    DeltaN = str2double(line2(42:56)) * 10^(str2double(line2(58:60)));
    MoAngle = str2double(line2(61:75)) * 10^(str2double(line2(77:79)));
    
    Cuc = str2double(line3(4:18)) * 10^(str2double(line3(20:22)));
    Eccent = str2double(line3(23:37)) * 10^(str2double(line3(39:41)));
    Cus = str2double(line3(42:56)) * 10^(str2double(line3(58:60)));
    SqrtA = str2double(line3(61:75)) * 10^(str2double(line3(77:79)));
    
    Toe = str2double(line4(4:18)) * 10^(str2double(line4(20:22)));
    Cic = str2double(line4(23:37)) * 10^(str2double(line4(39:41)));
    OMEGA = str2double(line4(42:56)) * 10^(str2double(line4(58:60)));
    Cis = str2double(line4(61:75)) * 10^(str2double(line4(77:79)));
    
    Io = str2double(line5(4:18)) * 10^(str2double(line5(20:22)));
    Crc = str2double(line5(23:37)) * 10^(str2double(line5(39:41)));
    Omega = str2double(line5(42:56)) * 10^(str2double(line5(58:60)));
    OMEGADot = str2double(line5(61:75)) * 10^(str2double(line5(77:79)));

    IDot = str2double(line6(4:18)) * 10^(str2double(line6(20:22)));
    L2 = str2double(line6(23:37)) * 10^(str2double(line6(39:41)));
    GPSWeek = str2double(line6(42:56)) * 10^(str2double(line6(58:60)));
    L2P = str2double(line6(61:75)) * 10^(str2double(line6(77:79)));    
    
    SVAccu = str2double(line7(4:18)) * 10^(str2double(line7(20:22)));
    SVHealth = str2double(line7(23:37)) * 10^(str2double(line7(39:41)));
    TGD = str2double(line7(42:56)) * 10^(str2double(line7(58:60)));
    IODC = str2double(line7(61:75)) * 10^(str2double(line7(77:79)));   
    
    TransTime = str2double(line8(4:18)) * 10^(str2double(line8(20:22)));
    FitInterval = str2double(line8(23:37)) * 10^(str2double(line8(39:41)));       
    
    LINE1 = [GPS_ID Time ClockBias ClockDrift ClockDriftRate];
    LINE2 = [Iode Crs DeltaN MoAngle];
    LINE3 = [Cuc Eccent Cus SqrtA];
    LINE4 = [Toe Cic OMEGA Cis];
    LINE5 = [Io Crc Omega OMEGADot];
    LINE6 = [IDot L2 GPSWeek L2P];
    LINE7 = [SVAccu SVHealth TGD IODC];
    LINE8 = [TransTime FitInterval];
    temp = [LINE1 LINE2 LINE3 LINE4 LINE5 LINE6 LINE7 LINE8];
    
    Nav_Out = [Nav_Out; temp]; % compiling output
    line = fgetl(fid);
end

end

