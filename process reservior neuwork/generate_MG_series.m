function data = generate_MG_series()
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
option=ddeset;
option.MaxStep=0.7;
option.InitialStep=0.7;
sol=dde23(@MGsystem,17,0.8,[0 5000],option);
data=sol.y'/10;