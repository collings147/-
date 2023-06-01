%% 薄板样条插值 
clc;clear;
load data5.mat
n_control_points = 10;
figure(1); 
hold on;
[X, Y] = meshgrid(x, y);
% [X, Y] = meshgrid(-1:0.1:1, -1:0.1:1);
[h, w] = size(X);% 获得网格的行数和列数 分别赋给h,w
[p,q] = meshgrid(1:h, 1:w);
pairs = [p(:) q(:)];% 生成一组坐标对
% 拉丁超立方采样
params = [min(x(:)) max(x(:)); min(y(:)) max(y(:)); min(f(:)) max(f(:))];
%将x、y和f值的范围确定为网格中的最小值和最大值。
%使用lhsdesign函数生成拉丁超立方样本,假设要生成50个采样点
n2 = 50;
samples = lhsdesign(n2, size(params, 1), 'criterion', 'maximin', 'iterations', 1000);
%将采样点转换为实际的x、y和f值，并将它们存储在一个矩阵中
sample_points = zeros(n2, 3);
for i = 1:size(params, 1)
    sample_points(:, i) = samples(:, i) * (params(i, 2) - params(i, 1)) + params(i, 1);
end

%用randperm从坐标对中随机选择n_control_points个坐标对
% cpoint_sub = pairs(randperm(h*w, n_control_points),:);


%用sub2ind将控制点坐标转为在x,y网格中的索引 并取出对应高度f 
%将控制点的坐标和高度组合成一个矩阵control_points ，其中每一行代表一个控制点。
control_points = horzcat( ...
    X(sub2ind(size(X), cpoint_sub(:,1), cpoint_sub(:,2))), ...
    Y(sub2ind(size(X), cpoint_sub(:,1), cpoint_sub(:,2))), ...
    f(sub2ind(size(X), cpoint_sub(:,1), cpoint_sub(:,2))));
% random displacements for the control points.  %控制点的随机位移
%生成和control_points大小相同的随机位移矩阵displacements 
displacements = (rand(size(control_points))-0.5)*0.5;
surf(X, Y, f)%绘制数据点
figure(2); clf; hold on;
%调用 find_tps_coefficients 函数计算TPS插值中的权重系数 mapping_coeffs 和 poly_coeffs
[mapping_coeffs, poly_coeffs] = ...
    find_tps_coefficients(control_points, displacements, 0);
%使用 deform_surface_tps 函数对原始数据进行插值，得到一个新的三维曲面
[fX, fY, fZ] = deform_surface_tps(X, Y, f, control_points, mapping_coeffs, poly_coeffs);
surf(fX, fY, fZ);% 绘制新的三维曲面
figure(3); clf; hold on;
%调用 find_tps_coefficients 函数计算TPS插值中的权重系数 mapping_coeffs 和 poly_coeffs 
[mapping_coeffs, poly_coeffs] = ...
    find_tps_coefficients(control_points, displacements, 0.3);
[fX, fY, fZ] = deform_surface_tps(X, Y, f, control_points, mapping_coeffs, poly_coeffs);
surf(fX, fY, fZ);
%% LHS采样  生成随机样本点
% p = 10; % Number of samples
% d = 2; % Dimension of each sample
% samples = lhsdesign(p, d);
% %计算他们的真实响应值
% rue_values = zeros(p, 1);
% for i = 1:p
% x1 = samples(i, 1);
% x2 = samples(i, 2);
% true_values(i) = x1^2 + x2^2;
% end
%将采样点和相应的响应值作为输入，调用 find_tps_coefficients 函数来计算薄板样条插值所需的映射系数和多项式系数
% control_points = samples;
% mapping_coeffs = zeros(p+d+1, 1);
% poly_coeffs = zeros(d+1, 1);
% [mapping_coeffs, poly_coeffs] = find_tps_coefficients(control_points, true_values);
%% 单点预测实现
control_point = [0.5, 0.5];
rbf = pairwise_radial_basis(surface, control_point);
v = [1; rbf; surface_point'];
response = v' * [mapping_coeffs; poly_coeffs];
%% 均方根误差
error = fZ - f;
rmse = sqrt(mean(error(:).^2));
disp(['RMSE: ', num2str(rmse)]);