function [ Obs_Out, XYZ, obs_types  ] = ObsReader( filename )
% Output format
% Element          1         2     3    4     5        6        7         8   9  10 11 12 13 14 15 16 17 18
% Obs_Out = [ObservationSet Year Month Day Time(DMS) GPSSec ClockOffset GPSID L1 L2 C1 P2 P1 S1 S2 D1 D2 C2

%% Observation data reader function

% Opening and Reading First line
fid = fopen(filename);
line = fgetl(fid);
linenumb = 1;
% Comparing Line Id with Required Data, then Storing it to Variable
while isequal(strfind(line, 'END OF HEADER'), [])
    if strfind(line, 'APPROX POSITION XYZ')
        XYZ = strsplit(line);
        XYZ = str2double(XYZ(2:4));
    elseif strfind(line, '# / TYPES OF OBSERV')
        types = strsplit(line);
        number_obs = str2double(types{2});
        obs_types = {};
        for i = 1:number_obs
            obs_types{i} = types{i+2};
        end
    end
    line = fgetl(fid); % Opening Next Line
    linenumb = linenumb + 1;
end
% identifying location of these signals so we can rearrange later to have a
% structured order of measurements regardless of file readin
signals = {'L1' 'L2' 'C1' 'P2' 'P1' 'S1' 'S2' 'D1' 'D2' 'C2'};

for i = 1: length(signals)
	temp = strcmp(signals{1,i},obs_types);
    index = find(temp == 1);
    if isempty(index) == 0
    signals{2,i} = {index};
    end
end
        
% At this point we've reached end of header

i = 1;
line = fgetl(fid);
linenumb = linenumb + 1;
Obs_Out = [];
while ischar(line)
    [ line ] = StandLength( line );
    if isempty(strfind(line, 'COMMENT')) == 1
    if length(str2double(strsplit(line(2:26)))) > 3
    [ line ] = StandLength( line );
    time = str2double(strsplit(line(2:26))); % epoch
    [ Time Weeks Seconds] = YYMMDDHHMMSS_2GPSSec( time );
    numb_sat = strsplit(line(30:32)); % number of satellites
    clock_off = str2double(strsplit(line(70:80))); % clock offset
    if isnan(clock_off) == 1
       clock_off = 0;  % is none indicated clock offset is 0
    end
    % satellites observed at epoch converted to number
    [ numb_sat ] = stringtonumb( numb_sat );   

    % getting Id of GPS satellites
    GPS_ID = [];
    GPS_ID_String = line(33:69); % getting GPS ids
    for j = 1:12
        if isnan(str2double(GPS_ID_String(j*3-1:j*3))) == 0
            GPS_ID = [GPS_ID; str2double(GPS_ID_String(j*3-1:j*3))];
        end
    end
    if numb_sat>12  % if more gps than 12 they will be on next line aswell
        line = fgetl(fid);
        [ line ] = StandLength( line );
        GPS_ID_String = line(33:69);
        for j = 1:12
        if isnan(str2double(GPS_ID_String(j*3-1:j*3))) == 0
            GPS_ID = [GPS_ID; str2double(GPS_ID_String(j*3-1:j*3))];
        end
        end
    end
    % collecting data
    obs_temp = [];
    for j = 1:numb_sat
        line = fgetl(fid);
        [ line ] = StandLength( line );
        line2 = fgetl(fid);
        [ line2 ] = StandLength( line2 );
        obs_temp(j,1) = i;
        obs_temp(j,2:6) = [time(1:3) dms2degrees(time(4:6)) Time];
        obs_temp(j,7) = clock_off;
        obs_temp(j,8) = GPS_ID(j);
        obs_temp(j,9) = str2double(line(1:14));
        obs_temp(j,10) = str2double(line(18:30));
        obs_temp(j,11) = str2double(line(34:46));
        obs_temp(j,12) = str2double(line(50:62));
        obs_temp(j,13) = str2double(line(66:78));
        obs_temp(j,14) = str2double(line2(1:14));
        obs_temp(j,15) = str2double(line2(18:30));
        obs_temp(j,16) = str2double(line2(34:46));
        obs_temp(j,17) = str2double(line2(50:62));
        obs_temp(j,18) = str2double(line2(66:78));
        linenumb = linenumb + 2;
    end
    % L1 L2 C1 P2 P1 S1 S2 D1 D2 C2 rearranging so every 
    % file has same structure.
    Temp = obs_temp;
    for iii = 1:length(signals)
        if isempty(cell2mat(signals{2,iii})) == 0
            Temp(:,8 + iii) = obs_temp(:,8 + cell2mat(signals{2,iii}));
        end
    % assembling to previous observations
    end
    Obs_Out = [Obs_Out;Temp];    
    i = i + 1; % iterate to collect for next epoch    
    end
    end
    line = fgetl(fid);
    linenumb = linenumb + 1;

end


end

