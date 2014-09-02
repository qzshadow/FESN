function [data, tag] = genarate_CBF(num,len,isRand)
t = 1:len;
data=zeros(num*2,len);
tag = zeros(num*2,1);
i = 0;
%C
% for i = 1:num
%     [y,a,b] = Xfun(t);
%     data(i,:) = (6+randn)*y + randn(1,len);
%     tag(i,1) = 0;
%     tag(i,2) = 0;
% end

%B
offset = i;
for i = 1+offset:num+offset
    [y,a,b] = Xfun(t);
    data(i,:) = (6+randn)*y.*(t-a)/(b-a) + randn(1,len);
    tag(i,1) = 0;
%     tag(i,2) = 1;
end

%F
offset = i;
for i = 1+offset:num+offset
    [y,a,b] = Xfun(t);
    data(i,:) = (6+randn)*y.*(a-t)/(b-a) + randn(1,len);
    tag(i,1) = 1;
%     tag(i,2) = 0;
end
if isRand == 1
    for i = 1:num*2
        a = fix(rand*num/2)+1;
        b = fix(rand*num/2)+fix(num/7*3);
        if a ~= b
            temp = data(a,:);
            data(a,:) = data(b,:);
            data(b,:) = temp;
            temp = tag(a,:);
            tag(a,:) = tag(b,:);
            tag(b,:) = temp;
        end
    end
end

function [y,a,b] = Xfun(x)
l = length(x);
a = fix(rand * 0.3*l) + 1;
b = min(l,fix(rand * 0.3*l) + fix(0.7*l));
y = x >= a;
yy = x <= b;
y = y & yy;