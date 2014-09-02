%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%testScript: test FESN               %
%test time series sequence classify  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% generate data
extract_rate = 1;
[data, tag, tag_class] = format_input( 'wafer_TRAIN', extract_rate);

extract_rate = 0.5;
[test_data, test_tag,test_tag_class] = format_input( 'wafer_TEST', extract_rate);

% data = low_filter( data, 3 );
% test_data = low_filter( test_data, 3 );

[ data ] = simpleData( data, 1);
[ test_data] = simpleData( test_data, 1);

[m n] = size(data);

%% train the network
inputDim = 1;
reservoir_size = 50;
fft_size = n;
reservoir_r = 0.999;
reservoir_sr = 0.007;
[ fesn ] = generate_fesn(inputDim,reservoir_size,fft_size,reservoir_r,reservoir_sr);

fesn = train_fesn(fesn,data,tag);
[pout] = test_fesn(fesn,data,tag);
[test_pout] = test_fesn(fesn,test_data,test_tag);

pout_class = format_output(pout);
test_pout_class = format_output(test_pout);

a = get_perClassNB(test_pout_class,test_tag_class);
test_pout_class = format_output(test_pout,a);

train_err = 1 - sum(pout_class == tag_class)/length(pout_class)
test_err = 1 - sum(test_pout_class == test_tag_class)/length(test_pout_class)
