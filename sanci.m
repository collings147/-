clc;
clear;
load data5.mat;
[X, Y] = meshgrid(x, y);
a=0;
for i=1:length(x)
    b=1;c=1;

for j=1:length(y)
    data(a*length(x)+b,1)=x(i);
    data(a*length(x)+b,2)=y(j);
    b=b+1;
end
for k=1:length(f)
    for k1=1:length(f)
        data(c,3)=f(k,k1);
        c=c+1;
    end
end
a=a+1;
end
% 绘制原始数据表面
figure(1);hold on;
surf(X, Y, f);

% LHS采样
params = [min(x(:)) max(x(:)); min(y(:)) max(y(:))];
% 将 x 和 y 的范围确定为网格中的最小值和最大值。
% 使用 lhsdesign 函数生成拉丁超立方样本，假设要生成 10 个采样点
n1 = 10;
samples = lhsdesign(n1, size(params, 1), 'criterion', 'maximin', 'iterations', 1000);
% 将采样点转换为实际的 x 和 y 坐标，并将它们存储在一个矩阵中
sample_points = zeros(n1, 2);
for i = 1:size(params, 1)
sample_points(:, i) = samples(:, i) * (params(i, 2) - params(i, 1)) + params(i, 1);
end

% 定义插值点的坐标
xi = linspace(min(sample_points(:,1)), max(sample_points(:,1)), 10);
yi = linspace(min(sample_points(:,2)), max(sample_points(:,2)), 10);
[Xi, Yi] = meshgrid(xi, yi);

% 进行三次多项式插值
Fi = interp2(x, y, f, Xi, Yi, 'spline');
% 假设第一个抽样点坐标为 sample_points(1,:)
x0 = sample_points(1, 1);
y0 = sample_points(1, 2);

% 使用 interp2 计算该点的响应值
f0 = interp2(x, y, f, x0, y0, 'spline');

% 绘制原始数据和插值结果
figure;
surf(x, y, f);
hold on;
surf(Xi, Yi, Fi);
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
title('三次多项式插值');
% legend('原始数据', '插值结果');

