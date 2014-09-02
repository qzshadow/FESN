function [ y ] = gaussFun( x )
%GAUSSFUN Summary of this function goes here
%   Detailed explanation goes here
a = 0.85;
y = exp(-(x/a).^2);
end

