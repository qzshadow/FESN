function ans = comERR(predict,teacher)
Lp=size(predict,1);
Lt=size(teacher,1);
if Lt>Lp
    d = Lt-Lp;
    teacher(1:d,:)=[];
end

D = sum((predict-teacher).^2);
S = Lp;
V = sum((teacher - mean(teacher)).^2);
mse = D/S;
rmse = sqrt(mse);
nmse = D/V;
nrmse = sqrt(nmse);
ans=[mse rmse nmse nrmse];
disp(['mse: ' num2str(mse)]);
disp(['rmse: ' num2str(rmse)]);
disp(['nmse: ' num2str(nmse)]);
disp(['nrmse: ' num2str(nrmse)]);