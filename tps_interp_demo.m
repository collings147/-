% Compute TPS interpolation on randomly chosen control points and deform
% the surface with the computed mapping coefficients.
% number of randomly chosen control points
clear; clc; close all;
data = xlsread("data1.xlsx");
f = data(:,3);
x = data(:,1);
y = data(:,2);
% 定义插值网格
[X,Y] = meshgrid(linspace(min(x), max(x), 100), linspace(min(y), max(y), 100));
% 计算插值函数
Z = griddata(x, y, f, X, Y);
% 绘制曲面图
surf(X, Y, Z);
xlabel('X');
ylabel('Y');
zlabel('Z');

n_control_points = 5;
figure(1); 
hold on;
%[X, Y] = meshgrid(x, y);
% [X, Y] = meshgrid(-1:0.1:1, -1:0.1:1);
[h, w] = size(X);

[p,q] = meshgrid(1:h, 1:w);
pairs = [p(:) q(:)];
cpoint_sub = pairs(randperm(h*w, n_control_points),:);

control_points = horzcat( ...
    X(sub2ind(size(X), cpoint_sub(:,1), cpoint_sub(:,2))), ...
    Y(sub2ind(size(X), cpoint_sub(:,1), cpoint_sub(:,2))), ...
    Z(sub2ind(size(X), cpoint_sub(:,1), cpoint_sub(:,2))));

% random displacements for the control points.  %控制点的随机位移
displacements = (rand(size(control_points))-0.5)*0.5;


surf(X, Y, Z)


figure(2); clf; hold on;

[mapping_coeffs, poly_coeffs] = ...
    find_tps_coefficients(control_points, displacements, 0);

[fX, fY, fZ] = deform_surface_tps(X, Y, Z, control_points, mapping_coeffs, poly_coeffs);

surf(fX, fY, fZ);

figure(3); clf; hold on;

[mapping_coeffs, poly_coeffs] = ...
    find_tps_coefficients(control_points, displacements, 0.3);

[fX, fY, fZ] = deform_surface_tps(X, Y, Z, control_points, mapping_coeffs, poly_coeffs);

surf(fX, fY, fZ);
%% 均方根误差
% error = fZ - f;
% rmse = sqrt(mean(error(:).^2));
% disp(['RMSE: ', num2str(rmse)]);