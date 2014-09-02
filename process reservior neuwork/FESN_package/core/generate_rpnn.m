function [ rpnn ] = generate_rpnn( inputNum, rNum, fftLen, R, sR)
%GENERATE_PESN Summary of this function goes here
%   Detailed explanation goes here

rpnn.inputNum = inputNum;
rpnn.reservoirNum = rNum;
if nargin<4
    R = 0.95;
    sR = 0.01;
elseif nargin<5
    sR = 0.01;
end

rpnn.sR = sR;
rpnn.R = R;
rpnn.fftLen = fftLen;

rpnn.Win = randn(rNum,inputNum);

if rNum^2*sR<50
    sR = 50/rNum^2;
end
mr = 0;
while mr==0
    rpnn.W = sprandn(rNum,rNum,sR);
    mr = max(abs(eig(full(rpnn.W))));
    rpnn.W = R*rpnn.W/mr;
end

rpnn.Wout = [];
end
