clc;
clear;
close all;
load data5.mat
%% 拉丁超立方采样
params = [min(x(:)) max(x(:)); min(y(:)) max(y(:)); min(f(:)) max(f(:))];
%将x、y和f值的范围确定为网格中的最小值和最大值。
%使用lhsdesign函数生成拉丁超立方样本,假设要生成50个采样点
n = 50;
samples = lhsdesign(n, size(params, 1), 'criterion', 'maximin', 'iterations', 1000);
%将采样点转换为实际的x、y和f值，并将它们存储在一个矩阵中
sample_points = zeros(n, 3);
for i = 1:size(params, 1)
    sample_points(:, i) = samples(:, i) * (params(i, 2) - params(i, 1)) + params(i, 1);
end
%% 
n_control_points = 20;
figure(1); 
hold on;
[X, Y] = meshgrid(x, y);
% [X, Y] = meshgrid(-1:0.1:1, -1:0.1:1);
[h, w] = size(X);
% %Z = repmat((-1:0.1:1), [h 1]);
% Z = repmat((-1:0.1:1).^(3), [h 1]);
[p,q] = meshgrid(1:h, 1:w);
pairs = [p(:) q(:)];
cpoint_sub = pairs(randperm(h*w, n_control_points),:);
control_points = horzcat( ...
    X(sub2ind(size(X), cpoint_sub(:,1), cpoint_sub(:,2))), ...
    Y(sub2ind(size(X), cpoint_sub(:,1), cpoint_sub(:,2))), ...
    f(sub2ind(size(X), cpoint_sub(:,1), cpoint_sub(:,2))));
displacements = (rand(size(control_points))-0.5)*0.5;
surf(X, Y, f)
figure(2); clf; hold on;

[mapping_coeffs, poly_coeffs] = ...
    find_tps_coefficients(control_points, displacements, 0);
[fX, fY, fZ] = deform_surface_tps(X, Y, f, control_points, mapping_coeffs, poly_coeffs);

surf(fX, fY, fZ);
figure(3); clf; hold on;
[mapping_coeffs, poly_coeffs] = ...
    find_tps_coefficients(control_points, displacements, 0.3);
[fX, fY, fZ] = deform_surface_tps(X, Y, f, control_points, mapping_coeffs, poly_coeffs);

surf(fX, fY, fZ);