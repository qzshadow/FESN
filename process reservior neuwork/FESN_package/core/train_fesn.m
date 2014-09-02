function [fesn] = train_fesn(fesn,input,output)
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
        
%         A(i,start:start+l-1) = M(k,:);
        
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

% [~,tag] = max(output');
% train_model = train(tag', sparse(A));

Wout = pinv(A) * output;
fesn.Wout = Wout;

% train_deepLearnNet(A,output);

% fesn.Wout = train_model;

    
    
    