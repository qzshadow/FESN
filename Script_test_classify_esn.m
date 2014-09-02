m = 100;
l = 100;
test_m = 10;
test_l = 100;

[data, tag] = genarate_CBF(m,l,0);
[test_data, test_tag] = genarate_CBF(test_m,test_l,0);

%数据预处理
% %  inData = data(:,1:end);
%  outData = data(:,1:end);
inData = [];
outData = [];
temp = zeros(l,1);
temp(end) = 0.5;
for i = 1:m
    inData = [inData;data(i,:)'];
    outData = [outData;temp];
end

 

nInputUnits = 1; nInternalUnits = 250; nOutputUnits = 1; nForgetPoints=0;
one_esn = generate_esn(nInputUnits, nInternalUnits, nOutputUnits, ...
    'spectralRadius',0.91,'nSubNet',1,'IDsubNet',1);

[one_esn,stateCollection] = train_esn(inData,outData,one_esn,nForgetPoints);

p = zeros(l,2*m);
train_err = zeros(2*m,1);
for i = 1:2*test_m
    p(:,i) = test_esn(test_data(i,:)',one_esn,nForgetPoints);
%     train_err(i) = compute_error(p(:,i), outData(i,:)');
end





