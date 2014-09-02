%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%testScript: test FESN               %
%test time series sequence classify  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% prepare data
dataStr = {'50words','Adiac','Beef','CBF','Coffee','ECG200','FaceAll','FaceFour',...
    'fish','Gun_Point','Lighting2','Lighting7','OliveOil','OSULeaf','SwedishLeaf',...
    'synthetic_control','Trace','Two_Patterns','wafer','yoga',...
    'ChlorineConcentration','CinC_ECG_torso','Cricket_X','Cricker_Y','Cricker_Z',...
    'DiatomSizeReduction','ECGFiveDays','FacesUCR','Haptics','InlineSkate','ItalyPowerDemand',...
    'MALLAT','MedicalImages','MoteStrain','SonyAIBORobotSurface','SonyAIBORobotSurfaceII',...
    'StarLightCurves','Symbols','TowLeadECG','uWaveGestureLibrary_X','uWaveGestureLibrary_Y',...
    'uWaveGestureLibrary_Z','WordsSynonyms'};
dataStr = {'50words','Adiac'};

for data_num = 1:length(dataStr)
    %% generate data
    try
        extract_rate = 1;
        [data, tag, tag_class] = format_input( [dataStr{data_num},'_TRAIN'], extract_rate);
        
        extract_rate = 0.5;
        [test_data, test_tag,test_tag_class] = format_input( [dataStr{data_num},'_TEST'], extract_rate);
    catch
        disp(['load file ',dataStr{data_num},' ERROR!'])
        continue;
    end
    % data = low_filter( data, 3 );
    % test_data = low_filter( test_data, 3 );
    
    [ data ] = simpleData( data, 1);
    [ test_data] = simpleData( test_data, 1);
    
    [m_train n_train] = size(data);
    [m_test n_test] = size(test_data);
    
    %% train the network
    inputDim = 1;
    reservoir_size = floor(32000/n_test);
    %     reservoir_size = 50;
    fft_size = n_test;
    reservoir_r = 0.999;
    reservoir_sr = 0.008;
    [ fesn ] = generate_fesn(inputDim,reservoir_size,fft_size,reservoir_r,reservoir_sr);
    try
        fesn = train_fesn(fesn,data,tag);
    catch
        disp(['train_fesn ERROR! ',dataStr{data_num}])
        continue;
    end
    [pout] = test_fesn(fesn,data,tag);
    [test_pout] = test_fesn(fesn,test_data,test_tag);
    
    pout_class = format_output(pout);
    test_pout_class = format_output(test_pout);
    
    a = get_perClassNB(test_pout_class,test_tag_class);
    test_pout_class = format_output(test_pout,a);
    
    train_err = 1 - sum(pout_class == tag_class)/length(pout_class);
    test_err = 1 - sum(test_pout_class == test_tag_class)/length(test_pout_class);
    
    disp([dataStr{data_num},' Done!'])
    
    %% write to file
    fid = fopen('result.txt','a+');
    fprintf(fid,'%s,%d,%d,%d,%d,%f,%d,%f,%f,%f,%f\n',dataStr{data_num},m_train,m_test,n_test,...
        reservoir_size,fesn.sR,fft_size,reservoir_r,reservoir_sr,train_err,test_err);
    fclose(fid);
end
