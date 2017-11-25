%% aa load the file
% compare wamos to gps

clear all
close all

%% load the GPS data
%file path
fgps='/home/unimelb.edu.au/aalberello/EPFL/motion_data/';
%ngps = 'ACE_Arenas-13_0.txt';
ngps = 'ACE_New_CapeTown-1_85.txt';
filename = ([fgps,ngps]);
M = aa_readgps(filename);

%% compute the spectrum

yy = M.alt(:,3);    %altitude third column
ll = 128;   %window
sf = 1; %sampling frequency
[ffr,pdm2] = aa_specalt( yy,sf,ll ); %frequency and spectrum
[ffrRoll,pdmRoll] = aa_specalt( M.roll,sf,ll ); %frequency and spectrum


%% %% load the GPS data
%file path
fwamos='/home/unimelb.edu.au/aalberello/EPFL/Data/2017_02/19/20/space/mean/FTHSPEC/';
nwamos = '20170219200737atr.FTM';
fnwamos = ([fwamos,nwamos]);

[ W ] = aa_readwamos( fnwamos );

ispw=W.isp; %integrated spectrum over theta
fre=W.ff; %frequency
%% correct WSpectrum for ship encouter freq

heam = angle(mean(exp(i*pi*M.hea/180)))*180/pi; % in degrees
wamm = W.sd; % in degrees
wamm = wamm +180;
uumm = mean(M.uu);
w=2*pi*W.ff;
for i=1:length(W.th)
    the = abs(heam-W.th(i)/180*pi); %angle theta
    we=w.*(1-w.*uumm/9.81*cos(the));
    swamos2d(:,i)=interp1(we,W.sp(:,i),w);
end

swamos2d(isnan(swamos2d))=0;
swamos = sum(swamos2d,2)./90;
    

%% interpolation
% find the df and limits for interpolation
f1 = max(ffr(1),fre(1));
f2 = min(ffr(end),fre(end));
def = min(mean(diff(ffr)),mean(diff(fre)));
% f1 =1/20;
% f2 =1/4;
% def = 1/500;

fin = [f1:def:f2]';
swamosi = interp1(fre,swamos,fin);
sgps = interp1(ffr,pdm2,fin);

%% transfer function
aa = sgps./swamosi; %take the ratio


% %delete the Nan and Inf
% xn0 = fl;
% yn0 = al;
% xn = isnan(xn0); yn = isnan(yn0); % find the locations of the NaNs
% xn0(xn | yn) = []; % delete elements from x that are NaN in x OR y
% yn0(xn | yn) = []; % delete elements from y that are NaN in x OR y
% fa = [xn0,yn0];
% xn = isinf(xn0); yn = isinf(yn0); % find the locations of the NaNs
% xn0(xn | yn) = []; % delete elements from x that are NaN in x OR y
% yn0(xn | yn) = []; % delete elements from y that are NaN in x OR y
% fa = [xn0,yn0];
% 
% %polynomial, 7 looks good
% pp = polyfit(fa(:,1),fa(:,2),7);

%% look at the tf
figure()
plot(fin,aa)

figure()
plot(1./fin,aa)
xlabel('Period [s]')

figure()
% contourf(fre,[2:4:358]',W.sp)
contourf(W.ff,W.th',W.sp')

figure()
subplot(2,1,1)
plot(1./fin,swamosi)
hold on
plot(1./fin,sgps)
xlabel('Period [s]'), xlim([0 50]), grid on
subplot(2,1,2)
plot(1./fin,aa)
xlabel('Period [s]'), xlim([0 50]), grid on
%% test how the tf works
% figure()
% plot(fin,swamos,'.')
% hold on
% plot(fin,sgps.*exp(polyval(pp,log(fin))),'-')
% legend('WAMOS','GPS reconstructed')

