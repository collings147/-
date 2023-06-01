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
surf(X, Y, f);%%用比较多的点构造了一个表面
%% 拉丁超立方采样
params = [min(x(:)) max(x(:)); min(y(:)) max(y(:)); min(f(:)) max(f(:))];
%将x、y和f值的范围确定为网格中的最小值和最大值。
%使用lhsdesign函数生成拉丁超立方样本,假设要生成50个采样点
n1 = 50;
samples = lhsdesign(n1, size(params, 1), 'criterion', 'maximin', 'iterations', 1000);
%将采样点转换为实际的x、y和f值，并将它们存储在一个矩阵中
sample_points = zeros(n1, 3);
for i = 1:size(params, 1)
    sample_points(:, i) = samples(:, i) * (params(i, 2) - params(i, 1)) + params(i, 1);
end
%% 对每个采样点使用克里金插值计算响应值
S=sample_points(:,1:2);
M=sample_points(:,3);
%模型参数设置，无特殊情况不需修改，见说明书
theta = [10 10]; lob = [1e-1 1e-1]; upb = [10 10];
%变异函数模型为高斯模型
[dmodel, perf] = dacefit(S , M, @regpoly0, @corrgauss, theta, lob, upb);
%创建一个21*21的格网，标注范围为-1到1，即格网间距为0.1
%S存储了点位坐标值，M为观测值
data1=sample_points(:,1:2);
%P=datasample(data1,200); 
 P = gridsamp([-0.0213 -0.0213;0.0817 0.0817], 10); %给定范围内的n维网格
%   P = lhsamp([-0.0213 -0.0213;0.0817 0.0817], 10); %给定范围内的n维网格
%  
% P = gridsamp([min(x) min(x);max(x) max(x)], 5);
%P=[83.731 32.36]; %单点预测的实现
%格网点的预测值返回在矩阵YX中，预测点的均方误差返回在矩阵MSE中
[YX,MSE] = predictor(P, dmodel); 
X1 = reshape(P(:,1),10,10); 
X2 = reshape(P(:,2),10,10);
YX = reshape(YX, size(X1)); %size(X1)=40*40
%figure(1), mesh(X1, X2, YX) %绘制预测表面
figure(3);
hold on
surf(X1, X2, YX);
plot3(sample_points(:,1),sample_points(:,2),sample_points(:,3),'.k') %绘制原始散点数据 
hold off
figure(4)
axis equal;
axis([-10 10 -10 10 -0.1 0.1]);
set(gcf, 'renderer', 'opengl');
set(gca, 'CameraPosition', [-400 400 200]);
surf(X1, X2, reshape(MSE,size(X1))); %绘制每个点的插值误差大小
%% 计算初始权因子Omega0 
PP = 0;
for i = 1:length(sample_points(:,1))
    % 计算采样点 i 在原始模型下的响应值和误差
    [YX, MSE]= predictor(sample_points(i, 1:2), dmodel);
    
    % 从采样点集合中删除采样点 i，生成新的采样点集合 new_data
    new_data = [];
    for j = 1:length(sample_points(:, 1))
        if j < i
            new_data(j, :) = sample_points(j, :);
        elseif j > i
            new_data(j-1, :) = sample_points(j, :);
        end
    end
    
    % 使用新采样点集合 new_data 训练新模型 new_dmodel，并计算新模型下的响应值和误差
    [new_dmodel, new_perf] = dacefit(new_data(:,1:2), new_data(:,3), @regpoly0, @corrgauss, theta, lob, upb);
    [new_YX, new_MSE] = predictor(sample_points(i, 1:2), new_dmodel);
    % 计算采样点 i 的初始权因子 p1，并将其加到 PP 中
l = 0.1 * std(sample_points(:, 3)); % 核函数长度尺度，可根据具体情况进行调整
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
%     %%公式
%     [new_YX,new_MSE ] = predictor(data(i,1:2), new_dmodel);
%     % p1
%     p1=sqrt(1/(YX-new_YX)^2);
%     PP=PP+p1;
%     Rmse=sqrt(new_MSE);
% end
% % omega=1/PP;
% 

%% 计算初始权因子Omega0 
P = 0;
for i = 1:length(sample_points(:,1))
    % 计算采样点 i 在原始模型下的响应值和误差
    [YX, MSE]= predictor(sample_points(i, 1:2), dmodel);
    
    % 从采样点集合中删除采样点 i，生成新的采样点集合 new_data
    new_data = [];
    for j = 1:length(sample_points(:, 1))
        if j < i
            new_data(j, :) = sample_points(j, :);
        elseif j > i
            new_data(j-1, :) = sample_points(j, :);
        end
    end
    
    % 使用新采样点集合 new_data 训练新模型 new_dmodel，并计算新模型下的响应值和误差
    [new_dmodel, new_perf] = dacefit(new_data(:,1:2), new_data(:,3), @regpoly0, @corrgauss, theta, lob, upb);
    [new_YX, new_MSE] = predictor(sample_points(i, 1:2), new_dmodel);
    % 计算采样点 i 的初始权因子 p1，并将其加到 PP 中
l = 0.1 * std(sample_points(:, 3)); % 核函数长度尺度，可根据具体情况进行调整
p1 = exp(-sum((YX - new_YX).^2) / (2 * l^2)) / sqrt(MSE + new_MSE);
PP = PP + p1;
%% 再次利用LHD采样，得到N个测试样本点
params = [min(x(:)) max(x(:)); min(y(:)) max(y(:)); min(f(:)) max(f(:))];
%将x、y和f值的范围确定为网格中的最小值和最大值。
%使用lhsdesign函数生成拉丁超立方样本,假设要生成50个采样点
n2 = 20;
samples = lhsdesign(n2, size(params, 1), 'criterion', 'maximin', 'iterations', 1000);
%将采样点转换为实际的x、y和f值，并将它们存储在一个矩阵中
sample_points2 = zeros(n2, 3);
for i = 1:size(params, 1)
    sample_points2(:, i) = samples(:, i) * (params(i, 2) - params(i, 1)) + params(i, 1);
end
% 计算他们的响应值
S=sample_points2(:,1:2);
M=sample_points2(:,3);
%模型参数设置，无特殊情况不需修改，见说明书
theta = [10 10]; lob = [1e-1 1e-1]; upb = [10 10];
%变异函数模型为高斯模型
[dmodel, perf] = dacefit(S , M, @regpoly0, @corrgauss, theta, lob, upb);
%创建一个21*21的格网，标注范围为-1到1，即格网间距为0.1
%S存储了点位坐标值，M为观测值
data1=sample_points2(:,1:2);
%P=datasample(data1,200); 
 P = gridsamp([-0.0213 -0.0213;0.0817 0.0817], 10); %给定范围内的n维网格
 %% 根据前面p个样本点及其响应值所构建的各个元模型，计算每个子模型的Rmse 
syms 
 Rmse=sqrt(((p1-PP)^2)/n1)
 %new_MSE2=new_MSE*omega;
 %% 找到最大最小Rmse
 if  new_MSE2> new_MSE
     new_MSE2=new_MSE;
 else 
     new_MSE;
 end
 RmseMax=new_MSE2;
 RmseMin=newMSE;
 
 %% 迭代停止判定
%  while RMSE
