function [out,tag] = readDataFromtxt(name,twoClassTag,flag)

if nargin <3
    flag = 0;
end
temp = load(name);
out1 = temp((temp(:,1) == twoClassTag(1)),:);
if flag == 0
    out2 = temp((temp(:,1) == twoClassTag(2)),:);
else
    out2 = temp((temp(:,1) ~= twoClassTag(1)),:);
end
tag = [zeros(length(out1(:,1)),1); ones(length(out2(:,1)),1)];
out = [out1(:,2:end);out2(:,2:end)];

