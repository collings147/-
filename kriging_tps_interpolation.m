function [Y_new] = kriging_tps_interpolation(X, Y, X_new, n_control_points, kriging_model, tps_smooth)

% 使用克里金插值函数预测输出变量的值
Y_kriging = dacefitting(X, Y, X_new, kriging_model);

% 使用 TPS 插值函数将预测值作为新的输入变量进行插值
[~, ~, Y_new] = tps_deformation(X, Y_kriging, X_new, n_control_points, tps_smooth);

end