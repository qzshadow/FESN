function [ y ] = dethafun( x )
%DETHAFUN Summary of this function goes here
%   Detailed explanation goes here
e = 0.05;
y = 1/pi * e./((x.^2 + e^2));

end

