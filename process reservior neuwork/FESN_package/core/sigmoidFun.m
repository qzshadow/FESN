function [ y] = sigmoidFun( x )
%SIGMOIDFUN Summary of this function goes here
%   Detailed explanation goes here
a = 3;%3.9;
y = 1./(1+exp(-a*x));
end

