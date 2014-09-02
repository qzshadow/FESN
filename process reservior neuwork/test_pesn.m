function [ pout, err ] = test_pesn( trained_pesn, input, output )
%T Summary of this function goes here
%   Detailed explanation goes here
[m,n] =size(input); %每一行是一个训练样本,即有m个样本，每个样本长n

if strcmp(trained_pesn.base, 'fft_base')
    [aInput] = fft_base(input);
    [aW] = trained_pesn.aW;
else
    [aInput] = input;
    [aW] = trained_pesn.aW;
end
v = trained_pesn.v;
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
pout = M*v;
err = output - pout;
% plot(err);
% figure;
% plot(output,'r:');
% hold on; plot(real(pout));

end

