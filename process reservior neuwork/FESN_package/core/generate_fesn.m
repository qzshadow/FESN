function [ fesn ] = generate_fesn( inputNum, rNum, fftLen, R, sR)
%GENERATE_PESN Summary of this function goes here
%   Detailed explanation goes here

fesn.inputNum = inputNum;
fesn.reservoirNum = rNum;
if nargin<4
    R = 0.95;
    sR = 0.01;
elseif nargin<5
    sR = 0.01;
end

fesn.sR = sR;
fesn.R = R;
fesn.fftLen = fftLen;

fesn.Win = randn(rNum,inputNum);

if rNum^2*sR<50
    sR = 50/rNum^2;
end
mr = 0;
while mr==0
    fesn.W = sprandn(rNum,rNum,sR);
%     fesn.W = orth(randn(rNum));
    mr = max(abs(eig(full(fesn.W))));
%     mr = max(abs(eig(fesn.W)));
    fesn.W = R*fesn.W/mr;
end

fesn.Wout = [];
end
