function [phasePoint teacherData]=phaseSpaceReconstruction(m,t,step,data)
%��ռ��ع�����������ʱ�����С�ά�����ӳٺ�Ԥ��Ĳ���������������
%mΪά����tΪ��ʱ��dataΪʱ������1*N����
%phaesPointΪ(N-step-(m-1)*t)*m�ľ���

%����phasePoint(i)=[data(i) data(i+t) ���� data(i+(m-1)t)]'
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
