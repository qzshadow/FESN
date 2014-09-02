function [ data, tag, tag_class ] = format_input( filename, extract_rate )
%FORMAT_INPUT 规范化输入数据及其类别标签

if nargin<2
    extract_rate = 1;
end

temp = load(filename);
temp = sortrows(temp,1);
temptag = temp(:,1);
id = unique(temptag);
num_class = length(id);

%% 抽样
if extract_rate < 1
    n_remove = fix(size(temp,1)* (1-extract_rate)) - 1;
    num_perClass = zeros(1,num_class);
    perClass{num_class} =[];
    for i = 1:num_class
        perClass{i} = temp(temptag == id(i),:);
        num_perClass(i) = size(perClass{i},1);
    end

    [sort_numPerClass, sortIndex_numPerClass] = sort(num_perClass,'descend');

    for kk = 1:num_class-1
        k = kk;
        if sum(sort_numPerClass(1:kk)) - kk*sort_numPerClass(kk+1) > n_remove
            break
        end
    end

    nn = fix((sum(sort_numPerClass(1:k))-n_remove) / k);

    for i = 1:k
        rand_rank = randperm(num_perClass(sortIndex_numPerClass(i)));
        perClass{sortIndex_numPerClass(i)}(rand_rank(nn+1:end),:) = [];
    end
    temp = [];
    for i = 1:num_class
        temp = [temp; perClass{i}];
    end
elseif extract_rate > 1
    n_add = fix(size(temp,1)* (extract_rate-1));
    num_perClass = zeros(1,num_class);
    perClass{num_class} =[];
    for i = 1:num_class
        perClass{i} = temp(temptag == id(i),:);
        num_perClass(i) = size(perClass{i},1);
    end
    
    n_all = sum(num_perClass);
    l_data = size(temp,2);
    for i = 1:num_class
        n_per_add = n_add/num_class; %fix((1/num_class - num_perClass(i)/n_all) * n_add);
        add_temp = perClass{i}(randi(num_perClass(i),n_per_add,1),:);
        perClass{i} = [perClass{i}; add_temp + [zeros(n_per_add,1), 0.5*(rand(n_per_add,l_data-1)-0.5)]];
    end

    temp = [];
    for i = 1:num_class
        temp = [temp; perClass{i}];
    end    
end

    

%% format 

temptag = temp(:,1);
data = temp(:,2:end);
num_data = length(temptag);

tag = zeros(num_data,num_class);
tag_class = zeros(num_data,1);
index = 1;
try
for i = 1:num_data
    while temptag(i) ~= id(index) 
        index = index +1;
    end
    tag(i,index) = 1;
    tag_class(i) = index;
end
catch
    i
end

