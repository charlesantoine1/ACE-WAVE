function [ M ] = aa_readgps( filename )
%aa_readgps reads the gps file
%   Detailed explanation goes here

delimiterIn = ' ';
%headerlinesIn = 1;
A = importdata(filename,delimiterIn);%,headerlinesIn);
nl = size(A,1);
% FormatCol=['%s%s'];
% for i=3:45
% FormatCol=[FormatCol '%f'];
% end
% B = textscan(filename,FormatCol,'commentStyle','None','delimiter', '\n','Headerlines',4);
for jj = 6:nl
    B(jj-5,:) = strsplit(A{jj});
end


%% convert in usable time
%A(2);% is the day
dd = strsplit(A{2}); dd = dd(4); dd = cell2mat(dd);
%B(1,1)% is the time
tt = cell2mat(B(1,1)); tt=tt(1:8);
dt = [dd,' ',tt];
dtn = datenum(dt); %this is a fraction of the day
M.daytimestr = dt;
M.daytimedbl = dtn;

%% create usable lat,lon, alt
% lat, lon at 16,17 and 32,33
% alt at 18, 26, 34

lat = B(:,[16,32]); lat = str2double(lat);
lon = B(:,[17,33]); lon = str2double(lon);
alt = B(:,[18,26,34,39]); alt = str2double(alt); alt = detrend(alt);
M.lat=lat;
M.lon=lon;
M.alt=alt;

%% heading and speed
un = B(:,9); un = str2double(un);%North speed m/s
ue = B(:,10); ue = str2double(ue);%East speed m/s
uu = sqrt(un.^2+ue.^2);

hea = B(:,3); hea = str2double(hea);%Heading degrees
M.roll=str2double(B(:,4)); % Roll
M.pitch=str2double(B(:,5)); % 
M.north=str2double(B(:,24)); %
M.east=str2double(B(:,25)); %

M.hea=hea;
M.uu=uu;

end

