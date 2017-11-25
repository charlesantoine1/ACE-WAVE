function [ M ] = aa_readwamos( filename )
%aa_readwamos reads wamos spectra
%   Detailed explanation goes here

hl ='Mth =  90';
md ='MDIR';

fid = fopen(filename);
tline = fgetl(fid);
jj = 0; %haven't hit the line yet
ii = 0;

fre = [];
spw = [];
while ischar(tline)
    tline = fgetl(fid);
    if tline(1:min(length(tline),5))=='SHIPR'; ds=tline; ds =strsplit(ds); ds = str2double(ds(2)); end
    if tline(1:min(length(tline),5))=='SHIPS'; us=tline; us =strsplit(us); us = str2double(us(2)); end
    if tline(1:min(length(tline),4))==md; sd=tline; sd =strsplit(sd); sd = str2double(sd(2)); end
    
    if tline==-1; break; end % terminate the loop using break statement 

    if tline(1:min(length(tline),9)) == hl(1:min(length(tline),9)); jj=1; end
    if jj == 1
        ii = ii+1;
        if ii>1 && ii<6
            tline = tline(:,2:end);
            ff = strsplit(tline);
            ff = str2double(ff);
            fre = [fre,ff];
        end
        if ii>=6
            spwt = strsplit(tline);
            spwt = str2double(spwt);
            spwt = spwt(2:end);
            spw = [spw,spwt]; 
        end            
    end
    
end

fclose(fid);
spw = reshape(spw,65,90);
th = spw(1,:);
spw = spw(2:end,:);

ispw = sum(spw')./90;

%%
M.sp=spw; %directional
M.isp=ispw; %integrated
M.ff=fre; %frequency
M.th=th; %angle
M.us=us; %ship speed kn
M.ds=ds; %ship direction

M.sd =sd; %spectrum direction coming from

end

