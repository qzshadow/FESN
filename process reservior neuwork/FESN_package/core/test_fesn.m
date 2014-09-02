function y = test_fesn(fesn,input,output)
[n,l] = size(input);
N = fesn.reservoirNum;
Win = fesn.Win;
W = fesn.W;
A = zeros(n,N*fesn.fftLen);

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
    
    start = 1;
    for k = 1:N
        A(i,start:start+fesn.fftLen-1) = fft(M(k,:),fesn.fftLen);
        
%         A(i,start:start+l-1) = M(k,:);
        
        start = start + fesn.fftLen;
    end
end


y = real(A * fesn.Wout);

% y = test_deepLearnNet(A,output);


