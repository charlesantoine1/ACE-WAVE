function [  ] = epfl_fig( fnwa,fngps )
%epfl_fig save the fig
%   its a diagnostics


[ M ] = aa_readwamos( fnwa );
M.sp(:,end+1) = M.sp(:,1);
M.th(end+1)=M.th(end)+mean(diff(M.th));

f1 = figure('visible','off')
set(gcf, 'Units', 'pixels','pos',[675 549 900 450]);

subplot(2,2,[1 3])
fh = aa_pol( M.th*pi/180,M.ff,M.sp',0.5 ); hold on
plot([0 M.us/50*sin(pi/2-degtorad(M.ds))],[0 M.us/50*cos(pi/2-degtorad(M.ds))],'r','linewidth',2)

[tf,hh,hs] = epfl (fnwa, fngps);
% aa = sgps./swamosi; %take the ratio
% tf(:,1) = fin;
% tf(:,2) = aa;
% tf(:,3) = sgps;
% tf(:,4) = swamosi;
subplot(2,2,2)
plot(1./tf(:,1),tf(:,3),'linewidth',1)
hold on
plot(1./tf(:,1),tf(:,4),'linewidth',1)
xlabel ('T [s]'), ylabel ('PSD'), grid on, xlim([0 25]), ylim([0 2])
legend('WaMoS','Heave')

subplot(2,2,4)
plot(1./tf(:,1),tf(:,2),'k')
xlabel ('T [s]'), ylabel ('$S_{GPS}/S_{WaMoS}$'), grid on, xlim([0 25]), ylim([0 10])

print(f1,['/home/unimelb.edu.au/aalberello/EPFL/plots/fig',fnwa(end-20:end-7)],'-dpdf')
clear f1
end

