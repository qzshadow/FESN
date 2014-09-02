function output = preProcess_fesn_SVM(fesn,input,Wout)
%TRAIN_FESN_SVM Summary of this function goes here
%   Detailed explanation goes here

[n,l] = size(input);
N = fesn.reservoirNum;
Win = fesn.Win;
% W = fesn.W;
output = [];
for i = 1:n
    M = zeros(N,l);
    M(:,1) = Win*input(i,1);
    for j = 2:l
        M(:,j) = gaussFun(fesn.W*M(:,j-1) + Win*input(i,j));
    end
    output = [output;Wout*M];
end

