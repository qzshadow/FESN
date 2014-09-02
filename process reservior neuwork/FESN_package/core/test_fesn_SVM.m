function y = test_fesn_SVM(fesn,input,output_tag)
%TEST_FESN_SVM Summary of this function goes here
%   Detailed explanation goes here

[n,l] = size(input);
N = fesn.reservoirNum;
A = zeros(n,N*fesn.fftLen);

for i = 1:n
    M = zeros(N,l);
    M(:,1) = fesn.Win*input(i,1);
    for j = 2:l
%         M(:,j) = dethafun(fesn.W*M(:,j-1) + Win*input(i,j));
        M(:,j) = gaussFun(fesn.W*M(:,j-1) + fesn.Win*input(i,j));
%         M(:,j) = gaussFun(fesn.W*M(:,j-1)*0.95 + 0.05*M(:,j-1) + fesn.Win*input(i,j));
%         M(:,j) = sigmoidFun(fesn.W*M(:,j-1) + Win*input(i,j));
%         M(:,j) = tanh(fesn.W*M(:,j-1) + Win*input(i,j));
    end
    
    start = 1;
    for k = 1:N
        A(i,start:start+fesn.fftLen-1) = fft(M(k,:),fesn.fftLen);
        start = start + fesn.fftLen;
    end
end
clear M

% A = A*fesn.pcaMap.M;

% A = sparse(A);
y = svmpredict(output_tag, A, fesn.Wout);

% y = simlssvm(fesn.Wout,A);

end

