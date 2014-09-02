function [fft_base] = make_fft_base(n,l)
t = 2*pi/(2*pi+1)*([0:l-1]' + 0.5);
fft_base = zeros(l,n);
sqrtPi = sqrt(pi);
fft_base(:,1) = 1/sqrt(2*pi);
index = 2;
for i = 1:(n-1)/2
    fft_base(:,index) = cos(i*t)/sqrtPi;
    index = index + 1;
    fft_base(:,index) = sin(i*t)/sqrtPi;
    index = index + 1;
end

