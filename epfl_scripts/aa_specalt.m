function [ fr,sp ] = aa_specalt( yy,sf,ll)
%aa_specalt computes the spectrum
%   yy the signal, sf the sampling frequency, ll the window
delt = 1/sf;
nw = floor(size(yy,1)/ll);
yy = yy(1:nw*ll,:);
yy = reshape(yy,ll,nw);

yy2 = [yy(:,1:end-1);yy(:,2:end)]; %50% overlap
yy = yy2;
yy = detrend(yy); 

hn = hann(size(yy,1)); hn= repmat(hn,1,size(yy,2));
yy = yy.*hn;
ft = fft(yy);

fr = sf*(0:size(yy,1)/2)/size(yy,1);
df = mean(diff(fr));
pd = sqrt(2)*((2*abs(ft/size(yy,1))).^2)./(2*df);
pdm = (mean(pd'))';

sp = pdm(1:length(fr));
sp(fr<0.02)=0;

end

