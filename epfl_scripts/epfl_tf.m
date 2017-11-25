%% presentation


fwt = '/home/unimelb.edu.au/aalberello/EPFL/Data/2017_03/01/14/space/mean/FTHSPEC/20170301144750atr.FTM';
fgt = '/home/unimelb.edu.au/aalberello/EPFL/motion_data/ACE_New_CapeTown-1_85.txt'
epfl_fig(fwt,fgt)

[tf,hh,hs] = epfl (fwt, fgt);

fga = '/home/unimelb.edu.au/aalberello/EPFL/motion_data/ACE_New_CapeTown-1_86.txt';
fwa = '/home/unimelb.edu.au/aalberello/EPFL/Data/2017_03/01/15/space/mean/FTHSPEC/20170301154826atr.FTM';
% fga = fgt;
% fwa = fwt;

%% %% load the GPS data
M = aa_readgps(fga);
yy = M.alt(:,3);    %altitude third column
yy = detrend(yy,'linear',[1:128:length(yy)]);
ll = 128;   %window
sf = 1; %sampling frequency
[ffr,pdm2] = aa_specalt( yy,sf,ll ); %frequency and spectrum
% [ffrRoll,pdmRoll] = aa_specalt( M.roll,sf,ll ); %frequency and spectrum
hh = 4*std(yy);


%% %% load the WAMOS data
[ W ] = aa_readwamos( fwa );
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

% %% transfer function
% aa = sgps./swamosi; %take the ratio
% tf(:,1) = fin;
% tf(:,2) = aa;
% tf(:,3) = sgps;
% tf(:,4) = swamosi;

%% apply transfer function
ft = interp1(tf(:,1),tf(:,2),fin);
swamrec = sgps./ft;

figure()
plot(1./fin,sgps,'linewidth',1)
hold on
plot(1./fin,swamrec,'linewidth',1)
plot(1./fin,swamosi,'--','linewidth',1)
legend('GPS','Reconstructed WaMoS','Target WaMoS'), xlabel ('T [s]'), xlim([0 20]), grid on