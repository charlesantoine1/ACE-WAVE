function [ x2,y2 ] = rota( x1,y1,ra )
%rota takes time series u(x,y) and rotates of angle ra
%to obtain u(x',y')
%   angle positive from the x axis in anticlockwise direction
%   angle in radians
 
%create the complex number
c1 = x1+1i.*y1;
%rotate
c2 = abs(c1).*exp(1i.*(angle(c1)-ra));
%create x2,y2
x2 = real(c2);
y2 = imag(c2);
 
end
