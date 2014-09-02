function s = autoGetAttr( y,x )
%AUTOGETATTR Summary of this function goes here
%   Detailed explanation goes here
c = 10;
g = 0.0000001;
e0 = 0;
e1 = 0;
T = 100;
bestA0 = [0,0];
bestA1 = [0,0];
while T>1
    for i = 1:5
        c = fix(c+ max(4,0.1*T)*(rand-0.5));
        g = g*(1+0.3*(rand-0.5));
        ee = svmtrain(y, x,['-s 0 -c ' int2str(c) ' -e 0.000001 -g ' int2str(g) ' -m 500 -v 3']);
        if ee>e1
            e1 = ee;
            bestA1 = [c,g];
            if ee>e0
                bestA0 = [c,g];
            end
        elseif exp(-(1-ee)*50/T) > rand
            bestA1 = [c,g];
            e1 = ee;
        end
    end
    disp('====================================================================================')
    disp(['c = ' int2str(c) '  g = ' num2str(c) '  err = ', num2str(e1)]);
end
load autoAttr e0 e1 bestA0 bestA1
s = ['-s 0 -c ' int2str(c) ' -e 0.000001 -g ' int2str(g) ' -m 500'];
end
