function [ trained_pesn,err ] = train_pesn( pesn, input,output )
%TRAIN_PESN Summary of this function goes here
%   Detailed explanation goes here
trained_pesn = pesn;
[m,n] =size(input); %每一行是一个训练样本,即有m个样本，每个样本长n

if strcmp(trained_pesn.base , 'fft_base')
    [aInput] = fft_base(input);
    [aW] = rand(n,trained_pesn.reservoirNum) - 0.5;
else
    aInput = input;
%     aW = fft(eye(n))';
%     [aW] = randn(n,trained_pesn.reservoirNum);
    aW = orth(randn(n));
    if n<trained_pesn.reservoirNum
        aW(:,n+1:trained_pesn.reservoirNum) = randn(n,trained_pesn.reservoirNum-n);
    else
        aW(:,trained_pesn.reservoirNum+1:end) = [];
    end
    alpha = 1;
    for i = n:-1:1
        aW(i,:) = alpha*aW(i,:);
        alpha = alpha*0.91;
    end
end
    
v = rand(trained_pesn.reservoirNum,1);
M = zeros(m,trained_pesn.reservoirNum);
f = trained_pesn.fun;
for i = 1:m
    for j=1:trained_pesn.reservoirNum
        M(i,j) = f(aInput(i,:)*aW(:,j));
%         temp = 0;
%         for k=1:n
%             temp = tanh(temp + aInput(i,k)*aW(k,j));
%         end
%         M(i,j) = temp;
    end
end
v = pinv(M)*output;
trained_pesn.v=v;
trained_pesn.aW = aW;
%err = comERR(output, M*v);
% plot(err);
          
    

end

