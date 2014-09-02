function xdot=lorenzeqSystem(t,x)
p=10;
b=8/3;
r=28;

xdot=[p*(x(2)-x(1));
      -x(1)*x(3)+r*x(1)-x(2);
      x(1)*x(2)-b*x(3)];