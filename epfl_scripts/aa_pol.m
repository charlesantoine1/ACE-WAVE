function [ fh ] = aa_pol( th,fr,sp, frl);
%AA_POL polar plot
%   tehta angle fr frequency dp spectrum, limit in r
fr(fr>frl) = nan;
[fr,th] = meshgrid(fr,th);
x = fr.*cos(th);
y = fr.*sin(th);
% set (gcf, 'Position', [680 1 960/2 961/2])
h = polar(x,y);
hold on;
%view([-90 -90]) %direction to
view([90 -90]) %direction from
v = max(max(sp))*[0.1:0.05:1];
fh = contourf(x,y,sp,v,'edgecolor','none');
% fh = contour(x,y,sp);
set(h,'Visible','off'); % Hide the POLAR function data and leave annotations
axis off;% Turn off axes and set square aspect ratio
axis image;
hold off

end

