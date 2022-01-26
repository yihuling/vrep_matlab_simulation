function [gama,alpha,beta] = inversekinematics(x,y,z)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
h = 0.15;
hu = 0.35;
hl = 0.382;
l1 = sqrt(y * y + z * z);
l2 = sqrt(l1 * l1 - h * h);
angle1 = abs(atan(y/z));
angle2 = abs(atan(h/l2));
gama = - (angle1 - angle2);
l3 = sqrt(x * x + l2 * l2);
angle3 = acos((hu * hu + hl * hl - l3 * l3)/(2 * hu * hl));
beta = - (pi - angle3 );
angle4 = acos((hu * hu + l3 * l3 - hl * hl )/(2 * hu * l3));
angle5 = atan2(x,l2);
alpha = angle4 - angle5;
end

