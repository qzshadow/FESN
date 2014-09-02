function data=selectData_esn(inputData,dataNo,selectNo)
%选择指定区域selectNo的数据
%dataNo为数据的分区信息
data=inputData(dataNo==selectNo,:);
