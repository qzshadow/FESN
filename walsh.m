function y=walsh(x)
clc       
code_length=x;
% Initialization: -1=0 and +1=1
code=[1 1; 1 -1];        
[r1 c1]=size(code);
while r1<code_length 
    for i=1:r1
        for j=1:c1
            code(i+r1,j)=code(i,j);
        end
    end
    for j=1:c1
        for i=1:r1
            code(i,j+c1)=code(i,j);
        end
    end
    for i=1:r1
        for j=1:c1
            code(i+r1,j+c1)=-1*code(i,j);
        end
    end
    [r1 c1]=size(code);
end
% Checking mutual orthogonality of all rows
sum=0;
data=[];
rows=[];
for i=1:r1
    A=code(i,:);
    for j=1:r1
        B=code(j,:);
        for k=1:c1
            sum=sum+A(k)*B(k);
        end
        data=[data sum];
        sum=0;
    end
    count=0;
    for h=1:length(data)
        if data(h)>0
            count=count+1;
        end
    end
    data=[];
    if count<=1
        rows=[rows i];
    end
end
y=code;
if length(rows)==r1
    fprintf('All rows are orthgonal with each other')
else 
    fprintf('Following given rows are orthogonal with each other')
    rows
end