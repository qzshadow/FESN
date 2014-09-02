function targetout = test_deepLearnNet(digitdata,targets)
load weights
err=0;
err_cr=0;
counter=0;
num_class = size(targets,2);
makebatches;
[testnumcases testnumdims testnumbatches]=size(batchdata);
N=testnumcases;
for batch = 1:testnumbatches
  data = [batchdata(:,:,batch)];
  target = [batchtargets(:,:,batch)];
  data = [data ones(N,1)];
  w1probs = 1./(1 + exp(-data*w1)); w1probs = [w1probs  ones(N,1)];
  w2probs = 1./(1 + exp(-w1probs*w2)); w2probs = [w2probs ones(N,1)];
  w3probs = 1./(1 + exp(-w2probs*w3)); w3probs = [w3probs  ones(N,1)];
  targetout = exp(w3probs*w_class);
  targetout = targetout./repmat(sum(targetout,2),1,num_class);

  [I J]=max(targetout,[],2);
  [I1 J1]=max(target,[],2);
  counter=counter+length(find(J==J1));
  err_cr = err_cr- sum(sum( target(:,1:end).*log(targetout))) ;
end
 test_err=(testnumcases*testnumbatches-counter);
 test_crerr=err_cr/testnumbatches;
 fprintf(1,'Test # misclassified: %d (from %d) \t \n',...
            test_err,testnumcases*testnumbatches);





