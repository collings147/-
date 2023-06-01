%% ��������ƽ���������  ���ݼ����ֳ�5�ݣ�����5�۽�����֤
K = 5;
n_control_points = 50;
params = [0.1, 0.3, 0.5, 0.7, 0.9]; % ��ѡ���ƽ������
errors = zeros(length(params), K);
for i = 1:K
    % �����ݼ��ֳ�ѵ�����Ͳ��Լ�
    test_idx = (i-1)*floor(size(X,1)/K) + (1:floor(size(X,1)/K));
    train_idx = setdiff(1:size(X,1), test_idx);
    X_train = X(train_idx, :);
    Y_train = Y(train_idx, :);
    f_train = f(train_idx, :);
    X_test = X(test_idx, :);
    Y_test = Y(test_idx, :);
    f_test = f(test_idx, :);

    % ���ѡ����Ƶ��λ����
    [p,q] = meshgrid(1:size(X_train,1), 1:size(X_train,2));
    pairs = [p(:) q(:)];
    cpoint_sub = pairs(randperm(size(X_train,1)*size(X_train,2), n_control_points),:);
    control_points = horzcat(X_train(sub2ind(size(X_train), cpoint_sub(:,1), cpoint_sub(:,2))), ...
                             Y_train(sub2ind(size(X_train), cpoint_sub(:,1), cpoint_sub(:,2))), ...
                             f_train(sub2ind(size(X_train), cpoint_sub(:,1), cpoint_sub(:,2))));
    displacements = (rand(size(control_points))-0.5)*0.5;

    % ����ÿ��ƽ��������ʹ��ѵ�������TPS��ֵģ�Ͳ�������Լ���Ԥ�����
    for j = 1:length(params)
        [mapping_coeffs, poly_coeffs] = find_tps_coefficients(control_points, displacements, params(j));
        [fX, fY, fZ] = deform_surface_tps(X_test, Y_test, f_test, control_points, mapping_coeffs, poly_coeffs);
        errors(j, i) = sqrt(mean((fZ(:)-f_test(:)).^2));
    end
end

% ����ÿ��ƽ��������K�ν�����֤�е�ƽ��Ԥ�����
mean_errors = mean(errors, 2);

% ѡ��ƽ��Ԥ�������С��ƽ��������Ϊ���ŵ�ƽ������
[~, idx] = min(mean_errors);
best_param = params(idx);