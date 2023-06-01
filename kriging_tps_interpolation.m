function [Y_new] = kriging_tps_interpolation(X, Y, X_new, n_control_points, kriging_model, tps_smooth)

% ʹ�ÿ�����ֵ����Ԥ�����������ֵ
Y_kriging = dacefitting(X, Y, X_new, kriging_model);

% ʹ�� TPS ��ֵ������Ԥ��ֵ��Ϊ�µ�����������в�ֵ
[~, ~, Y_new] = tps_deformation(X, Y_kriging, X_new, n_control_points, tps_smooth);

end