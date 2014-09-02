% t = 0.1:0.1:1000;
% % x = sin(t) + sin(3*t) + 1./(t+cos(t));
% load SunBlack.mat
% 
% l = 300;
% x = monthssn(:,4);
% xx = zeros(2800,l+1);
% for i = 1:2800
%     xx(i,:) = x(i:i+l);
% end
% y = xx(:,end);
% xx(:,end) = [];

% Êý¾Ý
data = generate_MG_series();

train_fraction = 0.6 ; % use 50% in training and 50% in testing
[trainData, testData] = split_train_test(data,train_fraction);
m=100;%mm(i);
t=1;%tt(i);
step=84;
[trainPhasePoint trainTeacherData]=phaseSpaceReconstruction(m,t,step,trainData);
[testPhasePoint testTeacherData]=phaseSpaceReconstruction(m,t,step,testData);

pesn = generate_pesn(1,500);
pesn = train_pesn(pesn,trainPhasePoint,trainTeacherData);
[pout, err] = test_pesn(pesn,testPhasePoint,testTeacherData);
% comERR(pout, testTeacherData)