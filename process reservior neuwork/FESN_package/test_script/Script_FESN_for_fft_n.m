%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%testScript: test fesn               %
%test time series sequence classify  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% generate data

[data, tag] = readDataFromtxt('ECG200_TRAIN',[-1,1]);
[test_data, test_tag] = readDataFromtxt('ECG200_TEST',[-1,1]);

% [data, tag] = genarate_CBF(200,50,0);
% [test_data, test_tag] = genarate_CBF(100,50,0);

% [data,tag] = generate_TwoPart(200,40);
% data = data(1:400,:);
% tag = tag(1:400,2);
% 
% [test_data,test_tag] = generate_TwoPart(100,40);
% test_data = test_data(1:200,:);
% test_tag = test_tag(1:200,2);

%% train the network
fftn = 10:10:300;
err = [];
ss = [];
train_time = zeros(length(fftn),1);
test_time = zeros(length(fftn),1);
for iter = 1:length(fftn)
    
    % fesn = generate_fesn(1,200);
    [ fesn ] = generate_fesn(1,200,fftn(iter),2);

    % fesn = train_fesn(fesn,data,tag);
    fesn = train_fesn(fesn,data,tag);

    % [pout, err] = test_fesn(fesn,test_data,test_tag);
    tic;
    [test_pout] = test_fesn(fesn,test_data,test_tag);
    train_time(iter) = toc;
    
    tic;
    [pout] = test_fesn(fesn,data,tag);
    test_time(iter) = toc;
%     figure;
%     plot(test_tag,'r');
%     hold on;
%     plot(test_pout,'.:');
%     plot(0.5*ones(length(test_pout),1),'r*-');
    twopoint = test_pout>0.5;
    err(iter) = sum(twopoint == test_tag)/length(test_tag)
    s = 0;
    for i = 1:length(twopoint)
        if (twopoint(i) == test_tag(i))
            s = s + (test_pout(i)-test_tag(i))^2;
        end
    end
    ss(iter) = s/sum(twopoint == test_tag)
end
        