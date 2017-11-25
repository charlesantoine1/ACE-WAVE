%% use epfl
clear all
close all

load gpsinfo_ARENAS;
cc_info = gpsinfo;
h = waitbar(0,'Please wait...');

ij = 0;
pp = [];
for jj = 1:2:length(gpsinfo)    %only use half for the calibration
    clear tf
    if ~isempty(gpsinfo(jj).fnl) %only goes in if it is not empty
        clear tf
        ij = ij+1;
        waitbar(jj / length(gpsinfo))
        %% read gps
        fgps='/home/unimelb.edu.au/aalberello/EPFL/motion_data/';
        ngps = gpsinfo(jj).nn;
        figps = ([fgps,ngps]);
        %% read wamos
        for kk = 1:size(gpsinfo(jj).fnl,1)
        fwa=(['/home/unimelb.edu.au/aalberello/EPFL/Data/',gpsinfo(jj).fnl(kk,1:4),'_',gpsinfo(jj).fnl(kk,5:6),'/',gpsinfo(jj).fnl(kk,7:8),'/',gpsinfo(jj).fnl(kk,9:10),'/space/mean/FTHSPEC/']);
        fnwa=([fwa,gpsinfo(jj).fnl(kk,:)]);
        
        %% operate
        clear tf
        [tf,hh,hs] = epfl (fnwa, figps);
        cc_info(jj).trfu(kk).tf=tf;
        cc_info(jj).trfu(kk).hh=hh;
        cc_info(jj).trfu(kk).hs=hs;
        end
        
    end
end

save ('cc_info','cc_info')