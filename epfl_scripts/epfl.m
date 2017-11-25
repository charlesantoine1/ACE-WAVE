function [tf,hh,hs] = epfl (fwamos, fgps)
%% gets the transfer function for the couple of files

%% %% load the GPS data
M = aa_readgps(fgps);
yy = M.alt(:,3);    %altitude third column
yy = detrend(yy,'linear',[1:128:length(yy)]);
ll = 128;   %window
sf = 1; %sampling frequency
[ffr,pdm2] = aa_specalt( yy,sf,ll ); %frequency and spectrum
% [ffrRoll,pdmRoll] = aa_specalt( M.roll,sf,ll ); %frequency and spectrum
hh = 4*std(yy);


%% %% load the WAMOS data
[ W ] = aa_readwamos( fwamos );
df = mean(diff(W.ff));
dt = mean(diff(W.th));
m0 = sum(sum(W.sp,2)).*df.*dt/180*pi;    %problem
hs = 4*sqrt(m0);

ispw=W.isp; %integrated spectrum over theta
fre=W.ff; %frequency
%% correct WSpectrum for ship encouter freq

heam = angle(mean(exp(i*pi*M.hea/180)))*180/pi; % in degrees
wamm = W.sd; % in degrees
wamm = wamm +180;
uumm = mean(M.uu);
w=2*pi*W.ff;
for ii=1:length(W.th)
    the = abs(heam-W.th(ii)/180*pi); %angle theta
    we=w.*(1-w.*uumm/9.81*cos(the));
    swamos2d(:,ii)=interp1(we,W.sp(:,ii),w);
end
swamos2d(isnan(swamos2d))=0;
swamos = sum(swamos2d,2)./90;
%% interpolation
% find the df and limits for interpolation
f1 = max(ffr(1),fre(1));
f2 = min(ffr(end),fre(end));
def = min(mean(diff(ffr)),mean(diff(fre)));
fin = [f1:def:f2]';
swamosi = interp1(fre,swamos,fin);
sgps = interp1(ffr,pdm2,fin);

%% transfer function
aa = sgps./swamosi; %take the ratio
tf(:,1) = fin;
tf(:,2) = aa;
tf(:,3) = sgps;
tf(:,4) = swamosi;

end