function [phasePoint teacherData]=phaseSpaceReconstruction(m,t,step,data)
%相空间重构，根据输入时间序列、维数、延迟和预测的步数，把数据重组
%m为维数，t为延时，data为时间序列1*N向量
%phaesPoint为(N-step-(m-1)*t)*m的矩阵

%其中phasePoint(i)=[data(i) data(i+t) …… data(i+(m-1)t)]'
%teacherData(i)=data(i+(m-1)t+step)

N=length(data);
nPhasePoint=N-step-(m-1)*t;
phasePoint=zeros(nPhasePoint,m);
for iData=1:nPhasePoint
    for iM=1:m
        phasePoint(iData,iM)=data(iData+(iM-1)*t);
    end
    teacherData(iData,1)=data(iData+(m-1)*t+step);
%     teacherData(iData,2)=data(iData+(m-1)*t+step-t);
end
