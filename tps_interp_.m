% Compute TPS interpolation on randomly chosen control points and deform
% the surface with the computed mapping coefficients.
% number of randomly chosen control points
clc;
clear;
close all;
load data2.mat
n_control_points =20;
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

% random displacements for the control points.
displacements = (rand(size(control_points))-0.5)*0.5;


surf(X, Y, f)
shading interp;

figure(2); clf; hold on;


[mapping_coeffs, poly_coeffs] = ...
find_tps_coefficients(control_points, displacements, 0.1);

[fX, fY, fZ] = deform_surface_tps(X, Y, f, control_points, mapping_coeffs, poly_coeffs);
surf(fX, fY, fZ);
shading interp;
figure(3); clf; hold on;

[mapping_coeffs, poly_coeffs] = ...
find_tps_coefficients(control_points, displacements, 0.3);

[fX, fY, fZ] = deform_surface_tps(X, Y, f, control_points, mapping_coeffs, poly_coeffs);

surf(fX, fY, fZ);
shading interp;

% 计算插�?�结果和原始数据之间的误�?
error = fZ - f;
% 计算均方根误�?
rmse = sqrt(mean(error(:).^2));
disp(['RMSE: ', num2str(rmse)]);

% 计算�?小二乘平�?
A = [ones(numel(fX), 1), fX(:), fY(:)];
b = fZ(:);
coeffs = A \ b;
plane = reshape(coeffs(1) + coeffs(2)*fX + coeffs(3)*fY, size(fX));

% 计算上下包容�?
upper_surface = plane + rmse;
lower_surface = plane - rmse;

% 绘制�?小二乘平面和上下包容�?
figure(4); clf; hold on;
surf(fX, fY, upper_surface, 'FaceColor', 'g', 'EdgeColor', 'none');
surf(fX, fY, lower_surface, 'FaceColor', 'y', 'EdgeColor', 'none');
surf(fX, fY, plane, 'FaceColor', 'b', 'EdgeColor', 'none', 'FaceAlpha', 0.5);
colormap winter;
legend({'上包容面', '下包容面', '�?小二乘平�?'});

% Compute residuals and RMSE
residuals = fZ - f;
SSres = sum(residuals.^2);
SStot = sum((fZ - mean(fZ(:))).^2);
R2 = 1 - SSres/SStot;
RMSE = sqrt(mean(residuals(:).^2));
fprintf('Residuals: %f\n', residuals);
fprintf('Residuals Squared Sum: %f\n', SSres);
fprintf('RMSE: %f\n', RMSE);
fprintf('R-Square: %f\n', R2);

% Compute least squares plane
A = [ones(numel(X),1) X(:) Y(:)];
c = A\fZ(:);
lsq_plane = reshape(A*c, size(X));

% Plot the original surface, TPS surface, residuals, and least squares plane
figure;
subplot(2,2,1);
surf(X, Y, f);
shading interp;
title('理想平面');
subplot(2,2,2);
surf(fX, fY, fZ);
shading interp;
title('薄板样条插�?�平�?');
subplot(2,2,3);
surf(X, Y, residuals);
title('残差平面');
shading interp;
subplot(2,2,4);
surf(X, Y, lsq_plane);
shading interp;
title('�?小二乘平�?');

% Plot the upper and lower bounds of the residuals as a shaded area
figure;
hold on;
surf(X, Y, fZ);
shading interp
caxis([min(f(:)) max(f(:))]);
alpha(0.5);
surf(X, Y, f - RMSE);
shading interp
alpha(0.5);
surf(X, Y, f + RMSE);
shading interp
alpha(0.5);
title('残差及上下包容面');