%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%testScript: test FESN_SVMoutput     %
%test time series sequence classify  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% generate data
extract_rate = 1;
[data, tag, tag_class] = format_input( 'Two_Patterns_TRAIN', extract_rate);
% extract_rate = 0.4;
% [test_data, test_tag,test_tag_class] = format_input( 'OSULeaf_TEST', extract_rate);
% 
% data = [data; test_data];
% tag = [tag; test_tag];
% tag_class = [tag_class; test_tag_class];

extract_rate = 0.3;
[test_data, test_tag,test_tag_class] = format_input( 'Two_Patterns_TEST', extract_rate);

% tag = 2*tag - 1;
% test_tag = 2*test_tag -1;

[ data ] = simpleData( data, 1);
[ test_data] = simpleData( test_data, 1 );


%% train the network
[ fesn ] = generate_fesn(1,100,100,1);

% [Wout] = pretrain_fesn_SVM(fesn,data,tag_class);
% data = preProcess_fesn_SVM(fesn,data ,Wout);
% test_data = preProcess_fesn_SVM(fesn,test_data ,Wout);

fesn = train_fesn_SVM(fesn,data,tag_class);
pout_class = test_fesn_SVM(fesn,data,tag_class);


% clear data
test_pout_class = test_fesn_SVM(fesn,test_data,test_tag_class);
% test_pout_class = test_fesn_SVM(fesn,data,test_tag(:,8));

train_err = sum(pout_class == tag_class)/length(pout_class)
test_err = sum(test_pout_class == test_tag_class)/length(test_pout_class)