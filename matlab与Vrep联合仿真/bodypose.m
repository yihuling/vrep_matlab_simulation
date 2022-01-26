function [lf_AB,lb_AB,rf_AB,rb_AB] = bodypose(x,y,z,alpha,beta,gama)
l = 0.8;
w= 0.7;
b = 0.4;
alpha = deg2rad(alpha);
beta = deg2rad(beta);
gama = deg2rad(gama);
rotx = [1,0,0;0 cos(alpha),-sin(alpha);0 sin(alpha) cos(alpha)];
roty = [cos(beta) 0 sin(beta);0 1 0;-sin(beta) 0 cos(beta)];
rotz = [cos(gama) -sin(gama) 0;sin(gama) cos(gama) 0;0 0 1];
pos = [x,y,z];
R = rotx * roty * rotz;
OB_lf = 1/2*[l,w,0];
Oo = -pos;
oA_lf = 1/2*[l,b,0];
lf_AB = -Oo + OB_lf - (R*oA_lf')';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OB_lb = [-1/2*l,1/2*w,0];
Oo = -pos;
oA_lb = [-1/2*l,1/2*b,0];
lb_AB = -Oo + OB_lb - (R*oA_lb')';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OB_rf = [1/2*l,-1/2*w,0];
Oo = -pos;
oA_rf = [1/2*l,-1/2*b,0];
rf_AB = -Oo + OB_rf - (R*oA_rf')';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OB_rb = [-1/2*l,-1/2*w,0];
Oo = -pos;
oA_rb = [-1/2*l,-1/2*b,0];
rb_AB = -Oo + OB_rb - (R*oA_rb')';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% disp(lf_AB);
% disp(lb_AB);
% disp(rf_AB);
% disp(rb_AB);
end

