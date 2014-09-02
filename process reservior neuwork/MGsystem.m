function dx=MGsystem(t,x,z)
xlag=z(:,1);
%dx=0.2*xlag(1)/(1+xlag(1)^10-0.1*x);
dx=0.2*xlag(1)/(1+xlag(1)^10)-0.1*x;