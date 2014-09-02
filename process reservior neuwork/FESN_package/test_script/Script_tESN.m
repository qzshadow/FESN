%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%testScript: test time serier ESN output     %
%test time series sequence classify          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% generate data
extract_rate = 1;
[data, tag, tag_class] = format_input( 'Two_Patterns_TRAIN', extract_rate);

extract_rate = 0.4;
[test_data, test_tag,test_tag_class] = format_input( 'Two_Patterns_TEST', extract_rate);

[ data ] = simpleData( data,1);
[ test_data] = simpleData( test_data,1);


%% train the network
[ fesn ] = generate_fesn(1,100,500,1);

[Wout] = pretrain_fesn_SVM(fesn,data,tag_class);
data = preProcess_fesn_SVM(fesn,data ,Wout);
test_data = preProcess_fesn_SVM(fesn,test_data ,Wout);

pout_class = knnclassify(data,data,tag_class);

test_pout_class = knnclassify(test_data,data,tag_class);

train_err = sum(pout_class == tag_class)/length(pout_class)
test_err = sum(test_pout_class == test_tag_class)/length(test_pout_class)