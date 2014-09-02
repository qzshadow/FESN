function [ a ] = fft_base( x )
%FFT_BASE Summary of this function goes here
%   Detailed explanation goes here
[l,n] = size(x);
m = fft(eye(n));
x = x';
for i=1:l
    a(i,:) = m*x(:,i);
end


