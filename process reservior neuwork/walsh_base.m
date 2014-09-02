function a = walsh_base(x)
[m,n] = size(x);
a = zeros(m,n);
for i = 1:m
    a(i,:) = WalshTransform(x(i,:));
end