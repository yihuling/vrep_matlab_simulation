clc;
clear;
Ts = 1;
lamda = 1;
xs = -0.1;
xf = 0.1;
zs = -0.582;
h = 0.1;
x = []
z = []
for t = 0:0.01:Ts
    sigma = 2*pi*t/(lamda*Ts);
    xt = (xf - xs)*(sigma-sin(sigma))/(2*pi) + xs;
    zt = h*(1-cos(sigma))/2 + zs
    x = [x,xt];
    z = [z,zt];
end
figure;
plot(x,z);
