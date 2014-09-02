%test time series sequence classify
[data, tag] = genarate_CBF(400,50,0);
[test_data, test_tag] = genarate_CBF(400,50,0);

% pesn = generate_pesn(1,200);
[ pesn ] = generate_fpesn(1,200);

% pesn = train_pesn(pesn,data,tag);
pesn = train_fpesn(pesn,data,tag);

% [pout, err] = test_pesn(pesn,test_data,test_tag);
[test_pout, err] = test_fpesn(pesn,test_data,test_tag);
[pout, err] = test_fpesn(pesn,data,tag);