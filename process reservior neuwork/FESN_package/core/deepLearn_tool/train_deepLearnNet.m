function train_deepLearnNet(digitdata,targets)

maxepoch=20; 
num_class = size(targets,2);
numhid=200; numpen=1000; numpen2=500; 

% fprintf(1,'Converting Raw files into Matlab format \n');
% converter; 

fprintf(1,'Pretraining a deep autoencoder. \n');
fprintf(1,'The Science paper used 50 epochs. This uses %3i \n', maxepoch);

makebatches;
[numcases numdims numbatches]=size(batchdata);

%% 1st layer
fprintf(1,'Pretraining Layer 1 with RBM: %d-%d \n',numdims,numhid);
restart=1;
rbm;
hidrecbiases=hidbiases; 
save vhclassify vishid hidrecbiases visbiases;

%% 2st layer
fprintf(1,'\nPretraining Layer 2 with RBM: %d-%d \n',numhid,numpen);
batchdata=batchposhidprobs;
numhid=numpen;
restart=1;
rbm;
hidpen=vishid; penrecbiases=hidbiases; hidgenbiases=visbiases;
save hpclassify hidpen penrecbiases hidgenbiases;

%% 3st layer
fprintf(1,'\nPretraining Layer 3 with RBM: %d-%d \n',numpen,numpen2);
batchdata=batchposhidprobs;
numhid=numpen2;
restart=1;
rbm;
hidpen2=vishid; penrecbiases2=hidbiases; hidgenbiases2=visbiases;
save hp2classify hidpen2 penrecbiases2 hidgenbiases2;

train_backpropclassify; 

