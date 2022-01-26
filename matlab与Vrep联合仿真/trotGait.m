function [x,z] = trotGait(t,T)
Ts = 1/2 * T;
lamda = 1;
xs = -0.1;
xf = 0.1;
zs = -0.495;
h = 0.1;
if t <= Ts
    sigma = 2*pi*t/(lamda*Ts);
    x = (xf - xs)*(sigma-sin(sigma))/(2*pi) + xs;
    z = h*(1-cos(sigma))/2 + zs;
else
    x = xf - ((xf - xs)/(T - Ts)) * (t - Ts);
    z = zs;
end
end

