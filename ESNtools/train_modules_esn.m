function [trained_esn, stateCollection] = ...
    train_modules_esn(trainInput, trainOutput , esn, nForgetPoints,dataNo,accurate)
%模块化esn训练
%dataNo为列向量，与输入数据量数同多，用于标记某行数据输入哪个模块


trained_esn = esn;
% case 'offline_singleTimeSeries'
% trainInput and trainOutput each represent a single time series in
% an array of size sequenceLength x sequenceDimension
if strcmp(trained_esn.type, 'twi_esn')
    if size(trainInput,2) > 1
        trained_esn.avDist = ...
            mean(sqrt(sum(((trainInput(2:end,:) - trainInput(1:end - 1,:))').^2)));
    else
        trained_esn.avDist = mean(abs(trainInput(2:end,:) - trainInput(1:end - 1,:)));
    end
end
stateCollection = compute_statematrix(trainInput, trainOutput, trained_esn, nForgetPoints) ; 
teacherCollection = compute_teacher(trainOutput, trained_esn, nForgetPoints) ; 
%计算各模块的输出权重
dataNo=dataNo(nForgetPoints+1:end,:);
id=unique(dataNo(:,1));
if id(1)~=0
    id=[0;id];
end
% trained_esn.m_outputWeights = feval(trained_esn.methodWeightCompute,  stateCollection, teacherCollection) ;
for iSubNet=id(2:end)'
%     modul_state=stateCollection(dataNo==iSubNet,:);
%     modul_teacher=teacherCollection(dataNo==iSubNet,:);
    
    modul_state=stateCollection((dataNo(:,1)==iSubNet | dataNo(:,2)==iSubNet | dataNo(:,3)==iSubNet),:);
    modul_teacher=teacherCollection((dataNo(:,1)==iSubNet | dataNo(:,2)==iSubNet | dataNo(:,3)==iSubNet),:);
    
    if ~isempty(modul_teacher)
        trained_esn.outputWeights{iSubNet} = feval(trained_esn.methodWeightCompute,  modul_state, modul_teacher,accurate(iSubNet)) ;
%         trained_esn.outputWeights{iSubNet} = feval(trained_esn.methodWeightCompute,  modul_state, modul_teacher) ;
        trained_esn.trained(iSubNet) = 1 ; 
    end
end





%     %尝试使用bp网络代替线性回归
%     %----------------------------------------------------------------------
%     ll=size(modul_state,2);
%     trained_esn.net{iSubNet}=newff(repmat([-1,1],ll,1),[8 1],{'tansig','tansig','tansig'});
%     trained_esn.net{iSubNet}.trainParam.epochs=500;
%     trained_esn.net{iSubNet}.trainFcn='trainlm';
%     trained_esn.net{iSubNet}=train(trained_esn.net{iSubNet},modul_state',modul_teacher');
%     %----------------------------------------------------------------

