% 准备八维输入和相应的响应数据
clc;clear;
x = randi([1,5],200, 8); % 生成一个随机的100行8列的矩阵作为八维输入数据
y = sin(sum(x, 2)); % 根据输入数据生成相应的响应值
% 将输入和响应数据分别存储在一个矩阵中
data = [x, y];
% 使用fitrgp函数构建克里金插值模型
model = fitrgp(data(:, 1:8), data(:, 9));
% 定义新的八维输入向量x_new
x_new = randi([1,5],200, 8); % 生成一个随机的1行8列的向量作为新的输入数据
% 对新的输入向量x_new进行预测，得到相应的响应值
y_new = predict(model, x_new);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
% 打印预测结果
fprintf('预测结果为：%f\n', y_new);
figure(1);
plot(y_new,'*');