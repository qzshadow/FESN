function y = test_rpnn(rpnn,input,output)
[n,l] = size(input);
N = rpnn.reservoirNum;
Win = rpnn.Win;
W = rpnn.W;
A = zeros(n,N*rpnn.fftLen);

for i = 1:n
    M = zeros(N,l);
    M(:,1) = Win*input(i,1);
    for j = 2:l
%         M(:,j) = dethafun(rpnn.W*M(:,j-1) + Win*input(i,j));
        M(:,j) = gaussFun(rpnn.W*M(:,j-1) + Win*input(i,j));
%         M(:,j) = sigmoidFun(rpnn.W*M(:,j-1) + Win*input(i,j));
%         M(:,j) = tanh(rpnn.W*M(:,j-1) + Win*input(i,j));
    end
    
    start = 1;
    for k = 1:N
        A(i,start:start+rpnn.fftLen-1) = fft(M(k,:),rpnn.fftLen);
        start = start + rpnn.fftLen;
    end
end

y = real(A * rpnn.Wout);


