function [ a ] = get_perClassNB(pout,tout )
%GET_PERCLASSNB Summary of this function goes here
%   Detailed explanation goes here
id = unique(tout);
n_class = length(id);
a = zeros(1,n_class);
for i = 1:n_class
    a(i) = length(find(pout == i & tout == i)) /length(find(tout == i));
end

a = tanh(5*a);


