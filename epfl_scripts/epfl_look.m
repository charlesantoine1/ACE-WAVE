%% explore cc_info
clear all
close all

load cc_info

%%
hhv = [];
hsv = [];
viy =[];
for ii = 1:length(cc_info)
    if ~isempty(cc_info(ii).trfu) %only goes in if it is not empty
    for jj = 1:length(cc_info(ii).trfu)
    ff = cc_info(ii).trfu(jj).tf;
    
    [ix iy] = min(abs(1./ff(:,1)-15));
    if ff(iy,2) > 30
    viy = [viy; ii,jj,iy];
    else    
    figure(1), plot(1./ff(:,1),ff(:,2)), hold on
    hhv = [hhv;cc_info(ii).trfu(jj).hh];
    hsv = [hsv;cc_info(ii).trfu(jj).hs];
    end
    
    end
    end
end

figure(2), scatter(hhv,hsv)