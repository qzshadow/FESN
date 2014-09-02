function [data,tag] = generate_TwoPart(num,len)
data = zeros(num*4,len);
tag = zeros(num*4,1);
funSet = {@us,@us;@us,@ds;@ds,@us;@ds,@ds};
tagSet = [0,0;0,1;1,0;1,1];
for j = 0:3
    for i = 1:num
        e = randn(1,len);
        index = j*num + i;
        data(index,:) = makedata(funSet{j+1,1},funSet{j+1,2},e);
        tag(index,1) = tagSet(j+1,1);
        tag(index,2) = tagSet(j+1,2);
    end
end


    

function x = makedata(fun1,fun2,e)
l = length(e);
len1 = fix(rand*l/8) + 10;
len2 = fix(rand*l/8) + 10;
s1 = fix(rand*l/3)+1;
s2 = min(fix(rand*l/3) + 5 + s1 + len1,l - len2 -5);
x = fun1(e,s1,len1);
x = fun2(x,s2,len2);

function x = us(x,s,len)
l = min(length(x)-s, len);
x(s:s+fix(l/2)) = -5;
x(fix(l/2)+s+1:s+l) = 5;

function x = ds(x,s,len)
l = min(length(x)-s, len);
x(s:s+fix(l/2)) = 5;
x(fix(l/2)+s+1:l+s) = -5;