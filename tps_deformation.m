%% ����������ֵ 
clc;clear;
load data5.mat
n_control_points = 10;
figure(1); 
hold on;
[X, Y] = meshgrid(x, y);
% [X, Y] = meshgrid(-1:0.1:1, -1:0.1:1);
[h, w] = size(X);% ������������������ �ֱ𸳸�h,w
[p,q] = meshgrid(1:h, 1:w);
pairs = [p(:) q(:)];% ����һ�������
% ��������������
params = [min(x(:)) max(x(:)); min(y(:)) max(y(:)); min(f(:)) max(f(:))];
%��x��y��fֵ�ķ�Χȷ��Ϊ�����е���Сֵ�����ֵ��
%ʹ��lhsdesign����������������������,����Ҫ����50��������
n2 = 50;
samples = lhsdesign(n2, size(params, 1), 'criterion', 'maximin', 'iterations', 1000);
%��������ת��Ϊʵ�ʵ�x��y��fֵ���������Ǵ洢��һ��������
sample_points = zeros(n2, 3);
for i = 1:size(params, 1)
    sample_points(:, i) = samples(:, i) * (params(i, 2) - params(i, 1)) + params(i, 1);
end

%��randperm������������ѡ��n_control_points�������
% cpoint_sub = pairs(randperm(h*w, n_control_points),:);


%��sub2ind�����Ƶ�����תΪ��x,y�����е����� ��ȡ����Ӧ�߶�f 
%�����Ƶ������͸߶���ϳ�һ������control_points ������ÿһ�д���һ�����Ƶ㡣
control_points = horzcat( ...
    X(sub2ind(size(X), cpoint_sub(:,1), cpoint_sub(:,2))), ...
    Y(sub2ind(size(X), cpoint_sub(:,1), cpoint_sub(:,2))), ...
    f(sub2ind(size(X), cpoint_sub(:,1), cpoint_sub(:,2))));
% random displacements for the control points.  %���Ƶ�����λ��
%���ɺ�control_points��С��ͬ�����λ�ƾ���displacements 
displacements = (rand(size(control_points))-0.5)*0.5;
surf(X, Y, f)%�������ݵ�
figure(2); clf; hold on;
%���� find_tps_coefficients ��������TPS��ֵ�е�Ȩ��ϵ�� mapping_coeffs �� poly_coeffs
[mapping_coeffs, poly_coeffs] = ...
    find_tps_coefficients(control_points, displacements, 0);
%ʹ�� deform_surface_tps ������ԭʼ���ݽ��в�ֵ���õ�һ���µ���ά����
[fX, fY, fZ] = deform_surface_tps(X, Y, f, control_points, mapping_coeffs, poly_coeffs);
surf(fX, fY, fZ);% �����µ���ά����
figure(3); clf; hold on;
%���� find_tps_coefficients ��������TPS��ֵ�е�Ȩ��ϵ�� mapping_coeffs �� poly_coeffs 
[mapping_coeffs, poly_coeffs] = ...
    find_tps_coefficients(control_points, displacements, 0.3);
[fX, fY, fZ] = deform_surface_tps(X, Y, f, control_points, mapping_coeffs, poly_coeffs);
surf(fX, fY, fZ);
%% LHS����  �������������
% p = 10; % Number of samples
% d = 2; % Dimension of each sample
% samples = lhsdesign(p, d);
% %�������ǵ���ʵ��Ӧֵ
% rue_values = zeros(p, 1);
% for i = 1:p
% x1 = samples(i, 1);
% x2 = samples(i, 2);
% true_values(i) = x1^2 + x2^2;
% end
%�����������Ӧ����Ӧֵ��Ϊ���룬���� find_tps_coefficients ���������㱡��������ֵ�����ӳ��ϵ���Ͷ���ʽϵ��
% control_points = samples;
% mapping_coeffs = zeros(p+d+1, 1);
% poly_coeffs = zeros(d+1, 1);
% [mapping_coeffs, poly_coeffs] = find_tps_coefficients(control_points, true_values);
%% ����Ԥ��ʵ��
control_point = [0.5, 0.5];
rbf = pairwise_radial_basis(surface, control_point);
v = [1; rbf; surface_point'];
response = v' * [mapping_coeffs; poly_coeffs];
%% ���������
error = fZ - f;
rmse = sqrt(mean(error(:).^2));
disp(['RMSE: ', num2str(rmse)]);