function [ ans ] = low_filter( X, n,m )
%LOW_FILTER Summary of this function goes here
%   Detailed explanation goes here
% �����˲�ƽ��
[row,col] = size(X);
if n>=col
    error('n ����С�����г���')
end

if nargin<3
    ans = zeros(row,col-n);
    for i=1:row
        for j=1:col-n
            ans(i,j) = mean(X(i,j:j+n));
        end
    end
else
    ans = zeros(row,fix(col/m));
    for i=1:row
        index = 1;
        for j=1:m:col-n
            ans(i,index) = mean(X(i,j:j+n));
            index = index + 1;
        end
    end
end


end

