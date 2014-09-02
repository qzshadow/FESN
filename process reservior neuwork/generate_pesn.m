function [ pesn ] = generate_pesn( inputNum, rNum )
%GENERATE_PESN Summary of this function goes here
%   Detailed explanation goes here

pesn.inputNum = inputNum;
pesn.reservoirNum = rNum;
pesn.base = 'direct'; %'fft_base'; %
pesn.fun = @dethafun;

end

