function a = fft_base2(x)
[m,l] = size(x);
a = zeros(m,l);
theta = 2*pi/l;
for i = 1:m
    u1 = 0;
    u2 = 0;
    for j = l:-1:1
        u = x(i,j) + 2*cos(j * theta)*u1 - u2;
        u2 = u1;
        u1 = u;
    end
    
    flag = 1;
    for j = 1:l
        if (flag == 1)
            a(i,j) = 2/l * (x(i,j) + u1*cos(j*theta) - u2);
            flag = 0;
        else
            a(i,j) = 2/l * u1*sin(j*theta);
            flag = 1;
        end
    end
end

        