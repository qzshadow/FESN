function [Wout] = pretrain_fesn_SVM(fesn,input,output_tag)
%TRAIN_FESN_SVM Summary of this function goes here
%   Detailed explanation goes here

[n,l] = size(input);
N = fesn.reservoirNum;
Win = fesn.Win;
% W = fesn.W;
A = [];
for i = 1:n
    M = zeros(N,l);
    M(:,1) = Win*input(i,1);
    for j = 2:l
        M(:,j) = gaussFun(fesn.W*M(:,j-1) + Win*input(i,j));
    end
    
    A = [A,M];
end
MaxClass = max(output_tag);
output = [];
for i = 1:MaxClass
    tt = mean(input(output_tag==i,:));
    output = [output, repmat(tt,1,sum(output_tag==i))];
end
Wout = output*pinv(A);

