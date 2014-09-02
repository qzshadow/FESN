
%% input value
digitdata = (digitdata - min(min(digitdata)))/ (max(max(digitdata)) - min(min(digitdata)));
%targets
%num_class
numbatches = 74;
totnum=size(digitdata,1);
batchsize = fix(totnum/numbatches);
numdims  =  size(digitdata,2);

fprintf(1, 'Size of the training dataset= %5d \n', totnum);

%% body
rand('state',0); %so we know the permutation of the training data
randomorder=randperm(totnum);

batchdata = zeros(batchsize, numdims, numbatches);
batchtargets = zeros(batchsize, num_class, numbatches);

for b=1:numbatches
  batchdata(:,:,b) = digitdata(randomorder(1+(b-1)*batchsize:b*batchsize), :);
  batchtargets(:,:,b) = targets(randomorder(1+(b-1)*batchsize:b*batchsize), :);
end;
clear digitdata targets;
save batchdata_old batchdata;


%% output
%batchdata
%batchtargets