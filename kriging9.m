clc;clear;
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
figure(1);hold on;
surf(X, Y, f);%%�ñȽ϶�ĵ㹹����һ������
%% ��������������
params = [min(x(:)) max(x(:)); min(y(:)) max(y(:)); min(f(:)) max(f(:))];
%��x��y��fֵ�ķ�Χȷ��Ϊ�����е���Сֵ�����ֵ��
%ʹ��lhsdesign����������������������,����Ҫ����50��������
n1 = 50;
samples = lhsdesign(n1, size(params, 1), 'criterion', 'maximin', 'iterations', 1000);
%��������ת��Ϊʵ�ʵ�x��y��fֵ���������Ǵ洢��һ��������
sample_points = zeros(n1, 3);
for i = 1:size(params, 1)
    sample_points(:, i) = samples(:, i) * (params(i, 2) - params(i, 1)) + params(i, 1);
end
%% ��ÿ��������ʹ�ÿ�����ֵ������Ӧֵ
S=sample_points(:,1:2);
M=sample_points(:,3);
%ģ�Ͳ������ã���������������޸ģ���˵����
theta = [10 10]; lob = [1e-1 1e-1]; upb = [10 10];
%���캯��ģ��Ϊ��˹ģ��
[dmodel, perf] = dacefit(S , M, @regpoly0, @corrgauss, theta, lob, upb);
%����һ��21*21�ĸ�������ע��ΧΪ-1��1�����������Ϊ0.1
%S�洢�˵�λ����ֵ��MΪ�۲�ֵ
data1=sample_points(:,1:2);
%P=datasample(data1,200); 
 P = gridsamp([-0.0213 -0.0213;0.0817 0.0817], 10); %������Χ�ڵ�nά����
%   P = lhsamp([-0.0213 -0.0213;0.0817 0.0817], 10); %������Χ�ڵ�nά����
%  
% P = gridsamp([min(x) min(x);max(x) max(x)], 5);
%P=[83.731 32.36]; %����Ԥ���ʵ��
%�������Ԥ��ֵ�����ھ���YX�У�Ԥ���ľ��������ھ���MSE��
[YX,MSE] = predictor(P, dmodel); 
X1 = reshape(P(:,1),10,10); 
X2 = reshape(P(:,2),10,10);
YX = reshape(YX, size(X1)); %size(X1)=40*40
%figure(1), mesh(X1, X2, YX) %����Ԥ�����
figure(3);
hold on
surf(X1, X2, YX);
plot3(sample_points(:,1),sample_points(:,2),sample_points(:,3),'.k') %����ԭʼɢ������ 
hold off
figure(4)
axis equal;
axis([-10 10 -10 10 -0.1 0.1]);
set(gcf, 'renderer', 'opengl');
set(gca, 'CameraPosition', [-400 400 200]);
surf(X1, X2, reshape(MSE,size(X1))); %����ÿ����Ĳ�ֵ����С
%% �����ʼȨ����Omega0 
PP = 0;
for i = 1:length(sample_points(:,1))
    % ��������� i ��ԭʼģ���µ���Ӧֵ�����
    [YX, MSE]= predictor(sample_points(i, 1:2), dmodel);
    
    % �Ӳ����㼯����ɾ�������� i�������µĲ����㼯�� new_data
    new_data = [];
    for j = 1:length(sample_points(:, 1))
        if j < i
            new_data(j, :) = sample_points(j, :);
        elseif j > i
            new_data(j-1, :) = sample_points(j, :);
        end
    end
    
    % ʹ���²����㼯�� new_data ѵ����ģ�� new_dmodel����������ģ���µ���Ӧֵ�����
    [new_dmodel, new_perf] = dacefit(new_data(:,1:2), new_data(:,3), @regpoly0, @corrgauss, theta, lob, upb);
    [new_YX, new_MSE] = predictor(sample_points(i, 1:2), new_dmodel);
    % ��������� i �ĳ�ʼȨ���� p1��������ӵ� PP ��
l = 0.1 * std(sample_points(:, 3)); % �˺������ȳ߶ȣ��ɸ��ݾ���������е���
p1 = exp(-sum((YX - new_YX).^2) / (2 * l^2)) / sqrt(MSE + new_MSE);
PP = PP + p1;



% PP=0;
% for i=1:length(sample_points(:,1))
%     [YX,MSE] = predictor(sample_points(i,1:2), dmodel);
%     new_data=[];
%     for j=1:length(sample_points(:,1))
%         if j<i
%             new_data(j,:)=sample_points(j,:);
%         elseif j>i
%             new_data(j-1,:)=sample_points(j,:);
%         end
%     end
%     [new_dmodel, new_perf]=shuru(new_data);
%     %%��ʽ
%     [new_YX,new_MSE ] = predictor(data(i,1:2), new_dmodel);
%     % p1
%     p1=sqrt(1/(YX-new_YX)^2);
%     PP=PP+p1;
%     Rmse=sqrt(new_MSE);
% end
% % omega=1/PP;
% 

%% �����ʼȨ����Omega0 
P = 0;
for i = 1:length(sample_points(:,1))
    % ��������� i ��ԭʼģ���µ���Ӧֵ�����
    [YX, MSE]= predictor(sample_points(i, 1:2), dmodel);
    
    % �Ӳ����㼯����ɾ�������� i�������µĲ����㼯�� new_data
    new_data = [];
    for j = 1:length(sample_points(:, 1))
        if j < i
            new_data(j, :) = sample_points(j, :);
        elseif j > i
            new_data(j-1, :) = sample_points(j, :);
        end
    end
    
    % ʹ���²����㼯�� new_data ѵ����ģ�� new_dmodel����������ģ���µ���Ӧֵ�����
    [new_dmodel, new_perf] = dacefit(new_data(:,1:2), new_data(:,3), @regpoly0, @corrgauss, theta, lob, upb);
    [new_YX, new_MSE] = predictor(sample_points(i, 1:2), new_dmodel);
    % ��������� i �ĳ�ʼȨ���� p1��������ӵ� PP ��
l = 0.1 * std(sample_points(:, 3)); % �˺������ȳ߶ȣ��ɸ��ݾ���������е���
p1 = exp(-sum((YX - new_YX).^2) / (2 * l^2)) / sqrt(MSE + new_MSE);
PP = PP + p1;
%% �ٴ�����LHD�������õ�N������������
params = [min(x(:)) max(x(:)); min(y(:)) max(y(:)); min(f(:)) max(f(:))];
%��x��y��fֵ�ķ�Χȷ��Ϊ�����е���Сֵ�����ֵ��
%ʹ��lhsdesign����������������������,����Ҫ����50��������
n2 = 20;
samples = lhsdesign(n2, size(params, 1), 'criterion', 'maximin', 'iterations', 1000);
%��������ת��Ϊʵ�ʵ�x��y��fֵ���������Ǵ洢��һ��������
sample_points2 = zeros(n2, 3);
for i = 1:size(params, 1)
    sample_points2(:, i) = samples(:, i) * (params(i, 2) - params(i, 1)) + params(i, 1);
end
% �������ǵ���Ӧֵ
S=sample_points2(:,1:2);
M=sample_points2(:,3);
%ģ�Ͳ������ã���������������޸ģ���˵����
theta = [10 10]; lob = [1e-1 1e-1]; upb = [10 10];
%���캯��ģ��Ϊ��˹ģ��
[dmodel, perf] = dacefit(S , M, @regpoly0, @corrgauss, theta, lob, upb);
%����һ��21*21�ĸ�������ע��ΧΪ-1��1�����������Ϊ0.1
%S�洢�˵�λ����ֵ��MΪ�۲�ֵ
data1=sample_points2(:,1:2);
%P=datasample(data1,200); 
 P = gridsamp([-0.0213 -0.0213;0.0817 0.0817], 10); %������Χ�ڵ�nά����
 %% ����ǰ��p�������㼰����Ӧֵ�������ĸ���Ԫģ�ͣ�����ÿ����ģ�͵�Rmse 
syms 
 Rmse=sqrt(((p1-PP)^2)/n1)
 %new_MSE2=new_MSE*omega;
 %% �ҵ������СRmse
 if  new_MSE2> new_MSE
     new_MSE2=new_MSE;
 else 
     new_MSE;
 end
 RmseMax=new_MSE2;
 RmseMin=newMSE;
 
 %% ����ֹͣ�ж�
%  while RMSE
