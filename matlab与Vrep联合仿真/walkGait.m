function [x,z] = walkGait(t,T)
Ts = 1/4 * T;% 摆动项的时间
lamda = 1;
xs = -0.1;
xf = 0.1;
zs = -0.495;
h = 0.15;
if t <= Ts
    sigma = 2*pi*t/(lamda*Ts);
    xt = (xf - xs)*(sigma-sin(sigma))/(2*pi) + xs;
    zt = h*(1-cos(sigma))/2 + zs;
    x = xt;
    z = zt;
else
     x = (-(xf-xs)/(T-Ts)) * (t-Ts) + xf;
%     x = xs
    z = zs;
end
end

