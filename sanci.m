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
% ����ԭʼ���ݱ���
figure(1);hold on;
surf(X, Y, f);

% LHS����
params = [min(x(:)) max(x(:)); min(y(:)) max(y(:))];
% �� x �� y �ķ�Χȷ��Ϊ�����е���Сֵ�����ֵ��
% ʹ�� lhsdesign ����������������������������Ҫ���� 10 ��������
n1 = 10;
samples = lhsdesign(n1, size(params, 1), 'criterion', 'maximin', 'iterations', 1000);
% ��������ת��Ϊʵ�ʵ� x �� y ���꣬�������Ǵ洢��һ��������
sample_points = zeros(n1, 2);
for i = 1:size(params, 1)
sample_points(:, i) = samples(:, i) * (params(i, 2) - params(i, 1)) + params(i, 1);
end

% �����ֵ�������
xi = linspace(min(sample_points(:,1)), max(sample_points(:,1)), 10);
yi = linspace(min(sample_points(:,2)), max(sample_points(:,2)), 10);
[Xi, Yi] = meshgrid(xi, yi);

% �������ζ���ʽ��ֵ
Fi = interp2(x, y, f, Xi, Yi, 'spline');
% �����һ������������Ϊ sample_points(1,:)
x0 = sample_points(1, 1);
y0 = sample_points(1, 2);

% ʹ�� interp2 ����õ����Ӧֵ
f0 = interp2(x, y, f, x0, y0, 'spline');

% ����ԭʼ���ݺͲ�ֵ���
figure;
surf(x, y, f);
hold on;
surf(Xi, Yi, Fi);
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
title('���ζ���ʽ��ֵ');
% legend('ԭʼ����', '��ֵ���');

