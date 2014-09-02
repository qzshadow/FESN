function [rpnn] = train_rpnn(rpnn,input,output)
[n,l] = size(input);
N = rpnn.reservoirNum;
Win = rpnn.Win;
W = rpnn.W;
A = zeros(n,N*rpnn.fftLen);
% MM = zeros(n,l);
for i = 1:n
    M = zeros(N,l);
    M(:,1) = Win*input(i,1);
    for j = 2:l
%         M(:,j) = dethafun(rpnn.W*M(:,j-1) + Win*input(i,j));
        M(:,j) = gaussFun(rpnn.W*M(:,j-1) + Win*input(i,j));
%         M(:,j) = sigmoidFun(rpnn.W*M(:,j-1) + Win*input(i,j));
%         M(:,j) = tanh(rpnn.W*M(:,j-1) + Win*input(i,j));
    end
    
%     MM(i,:) = M(1,:);
    
    start = 1;
    for k = 1:N
        A(i,start:start+rpnn.fftLen-1) = fft(M(k,:),rpnn.fftLen);
        start = start + rpnn.fftLen;
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
try
Wout = pinv(A) * output;
catch
    i
end
rpnn.Wout = Wout;

    
    
    