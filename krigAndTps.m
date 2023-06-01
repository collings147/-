clc;clear;
load data5.mat
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

% 薄板样条插值
[X, Y] = meshgrid(x, y);
n_control_points = 50;
pairs = randperm(numel(X), n_control_points);
control_points = [X(pairs), Y(pairs), f(pairs)];
displacements = (rand(size(control_points))-0.5)*0.5;
[mapping_coeffs, poly_coeffs] = find_tps_coefficients(control_points, displacements, 0.3);
f_tps = deform_surface_tps(X, Y, f, control_points, mapping_coeffs, poly_coeffs);

% 克里金插值
x_kriging = x(:);
y_kriging = y(:);
z_kriging = f(:);
[xq, yq] = meshgrid(min(x):0.1:max(x), min(y):0.1:max(y));
zq = griddata(x_kriging, y_kriging, z_kriging, xq, yq, 'cubic');
f_kriging = zq;

% 加权组合
w_tps = 0.4;
w_kriging = 0.6;
f = w_tps * f_tps + w_kriging * f_kriging;

% 计算均方根误差
error = f - f_kriging;
rmse = sqrt(mean(error(:).^2));
disp(['RMSE: ', num2str(rmse)]);

% 可视化结果
figure;
subplot(1, 3, 1);
surf(X, Y, f_tps);
title('Thin plate spline interpolation');
subplot(1, 3, 2);
surf(xq, yq, f_kriging);
title('Kriging interpolation');
subplot(1, 3, 3);
surf(xq, yq, f);
title('Weighted ensemble interpolation');