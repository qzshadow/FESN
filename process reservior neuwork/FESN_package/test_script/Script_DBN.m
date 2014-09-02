%% generate data
extract_rate = 1;
[data, tag, tag_class] = format_input( 'FaceAll_TRAIN', extract_rate);
% extract_rate = 0.4;
% [test_data, test_tag,test_tag_class] = format_input( 'OSULeaf_TEST', extract_rate);
% 
% data = [data; test_data];
% tag = [tag; test_tag];
% tag_class = [tag_class; test_tag_class];

extract_rate = 1;
[test_data, test_tag,test_tag_class] = format_input( 'FaceAll_TEST', extract_rate);


[ data ] = simpleData( data, 1);
[ test_data] = simpleData( test_data, 1 );

for i = 1:size(data,1)
    data(i,:) =dct(data(i,:));
end
for i = 1:size(test_data,1)
    test_data(i,:) = dct(test_data(i,:));
end
train_deepLearnNet(data,tag);
y = test_deepLearnNet(test_data, test_tag);