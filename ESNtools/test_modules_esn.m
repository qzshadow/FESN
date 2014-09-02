function [outputSequence,stateCollectMat] = test_modules_esn(inputSequence, teacherSequence,esn, nForgetPoints, dataNo)
%模块化esn网络仿真输出
% if esn.trained(esn.IDsubNet) == 0
%     error(['The subESN #' num2str(esn.IDsubNet) 'is not trained. esn.trained = 1 for a trained network']) ; 
% end

[outputSequence,stateCollectMat] = m_compute_statematrix_outSequence(inputSequence, teacherSequence, esn,nForgetPoints,dataNo) ;     

% outputSequence = stateCollection * esn.outputWeights{esn.IDsubNet}' ; 
%%%% scale and shift the outputSequence back to its original size
nOutputPoints = length(outputSequence(:,1)) ; 
outputSequence = feval(esn.outputActivationFunction, outputSequence); 
outputSequence = outputSequence - repmat(esn.teacherShift',[nOutputPoints 1]) ; 
outputSequence = outputSequence / diag(esn.teacherScaling) ; 




function [outputSequence,stateCollectMat] = ...
    m_compute_statematrix_outSequence(inputSequence, teacherSequence, esn, nForgetPoints, dataNo)

if isempty(inputSequence) && isempty(outputSequence)
    error('error in compute_statematrix: two empty input args');
end

teacherForcing = 0;
nDataPoints = length(inputSequence(:,1));

stateCollectMat = ...
    zeros(nDataPoints - nForgetPoints, esn.nInputUnits + esn.nInternalUnits) ; 


%% set starting state

totalstate = zeros(esn.nInputUnits + esn.nInternalUnits + esn.nOutputUnits, 1);
internalState = zeros(esn.nInternalUnits, 1);


%%%% if nForgetPoints is negative, ramp up ESN by feeding first input
%%%% |nForgetPoints| many times

collectIndex = 0;
for i = 1:nDataPoints
    
    % scale and shift the value of the inputSequence
    if esn.nInputUnits > 0
        in = esn.inputScaling .* inputSequence(i,:)' + esn.inputShift;  % in is column vector
    else in = [];
    end
    
    % write input into totalstate
    if esn.nInputUnits > 0
        totalstate(esn.nInternalUnits+1:esn.nInternalUnits + esn.nInputUnits) = in;
    end    
    
    % the internal state is computed based on the type of the network
    switch esn.type
        case 'plain_esn'
            typeSpecificArg = [];
        case 'leaky_esn'
            typeSpecificArg = [];
        case 'leaky1_esn'
            typeSpecificArg = [];
        case 'twi_esn'
            if  esn.nInputUnits == 0
                error('twi_esn cannot be used without input to ESN');
            end
            if i == 1
                typeSpecificArg = esn.avDist;
            else
                typeSpecificArg = norm(inputSequence(i,:) - inputSequence(i-1,:));
            end
    end
    internalState = feval(esn.type, totalstate, esn, typeSpecificArg) ; 
    
    if i>1
        netOut = feval(esn.outputActivationFunction, esn.outputWeights{dataNo(i-1,1)} * [internalState; in]);
    else
        netOut = feval(esn.outputActivationFunction, esn.outputWeights{dataNo(1,1)} * [internalState; in]);
    end
%     netOut = feval(esn.outputActivationFunction, ESN.outputWeights{1} * [internalState; in]);
%     netOut = teacherSequence(i,:);
    
    totalstate = [internalState; in; netOut];
    
    %collect state
    if nForgetPoints >= 0 &&  i > nForgetPoints
        collectIndex = collectIndex + 1;
        stateCollectMat(collectIndex,:) = [internalState' in']; 
        outputSequence(collectIndex,:) = stateCollectMat(collectIndex,:) * esn.outputWeights{dataNo(i,1)}'; 
%         %尝试用bp代替线性回归
%         outputSequence(collectIndex,:) = sim(esn.net{dataNo(i,:)},stateCollectMat(collectIndex,:)');
%         %------------------------------------------------------------------
        
    end
    
end
