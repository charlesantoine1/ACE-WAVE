function [ yyf ] = aa_filtalt( yy,sf)
%aa_specalt computes the spectrum
%   yy the signal, sf the sampling frequency, times the peak
delt = 1/sf;
yy = detrend(yy);
if mod(size(yy,1),2) == 0 %number is even else %number is odd end
else yy = yy(:,1:end-1);
end

ft = fft(yy);
fr = sf*(0:size(yy,1)/2)/size(yy,1);
df = mean(diff(fr));

ftf = ft;
ftf(fr<1/15,:) = 0;
ftf(fr>1,:) = 0;

yyf = real(ifft(ftf));
end

