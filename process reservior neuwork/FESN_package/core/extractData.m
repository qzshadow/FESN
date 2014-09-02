function [ outX, outTag ] = extractData( x,tag, num1, num2 )
% Summary of this function goes here
%   Detailed explanation goes here
tic;
class1 = 0;
class2 = 1;

class1Set = x(tag==class1,:);
class2Set = x(tag==class2,:);

n1 = size(class1Set,1);
n2 = size(class2Set,1);

if n1<num1 || n2<num2
    error('num1 or num2 is too large');
end


outX = [class1Set(1:num1,:); class2Set(1:num2,:)];
outTag = [repmat(class1,num1,1);repmat(class2,num2,1)];
toc
end

