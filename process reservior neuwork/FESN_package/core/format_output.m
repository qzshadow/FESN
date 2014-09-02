function [ output ] = format_output( output_fesn, NB)
%FORMAT_OUTPUT Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    [~, output] = max(output_fesn');
    output = output';
else
    l = size(output_fesn,1);
    output_fesn = output_fesn.* (ones(l,1)*NB);
    [~, output] = max(output_fesn');
    output = output';

end

