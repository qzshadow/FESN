function [ y ] = simpleData( x, per )
%SIMPLEDATA 时间序列采样

[m,n] = size(x);

nn = max(fix(per*n),2);

inter = (n-1)/(nn-1);
point = 1:inter:n;
y = zeros(m,length(point));
for i = 1:m
    y(i,:) = interp1(1:n,x(i,:),point);
end
end

