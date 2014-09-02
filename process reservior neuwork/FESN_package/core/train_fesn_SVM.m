function [fesn] = train_fesn_SVM(fesn,input,output_tag)
%TRAIN_FESN_SVM Summary of this function goes here
%   Detailed explanation goes here

[n,l] = size(input);
N = fesn.reservoirNum;
Win = fesn.Win;
% W = fesn.W;
A = zeros(n,N*fesn.fftLen);
% MM = zeros(n,l);
for i = 1:n
    M = zeros(N,l);
    M(:,1) = Win*input(i,1);
    for j = 2:l
%         M(:,j) = dethafun(fesn.W*M(:,j-1) + Win*input(i,j));
        M(:,j) = gaussFun(fesn.W*M(:,j-1) + Win*input(i,j));
%         M(:,j) = gaussFun(fesn.W*M(:,j-1)*0.95 + 0.05*M(:,j-1) + Win*input(i,j));
%         M(:,j) = sigmoidFun(fesn.W*M(:,j-1) + Win*input(i,j));
%         M(:,j) = tanh(fesn.W*M(:,j-1) + Win*input(i,j));
    end
    
%     MM(i,:) = M(1,:);
    
    start = 1;
    for k = 1:N
        A(i,start:start+fesn.fftLen-1) = fft(M(k,:),fesn.fftLen);
        start = start + fesn.fftLen;
    end
end

% R = eye(n);
% for i = 1:n-1
%     for j = i+1:n
%         temp = CORRCOEF(MM(i,:),MM(j,:));
%         R(i,j) = temp(1,2);
%         R(j,i) = temp(1,2);
%     end
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wout = pinv(A) * output_tag;
% [~,pcaMap] = pca(A,100);
% fesn.pcaMap = pcaMap;
% A = A*pcaMap.M;

% A = sparse(A);
% s = autoGetAttr( output_tag,A );
% train_model = svmtrain(output_tag, A,s);
train_model = svmtrain(output_tag, A,'-s 0 -c 600 -e 0.00000001 -g 0.0000004 -m 500');
% model = initlssvm(A,output_tag,'c',[],[],'RBF_kernel');
% model = tunelssvm(model);
% train_model = trainlssvm(model);

fesn.Wout = train_model;

end

