clc;clear

load data3.mat  %载入数据
%模型参数设置，无特殊情况不需修改，见说明书
theta = [10 10]; lob = [1e-1 1e-1]; upb = [20 20];
%变异函数模型为高斯模型
[dmodel, perf] = dacefit(x, y, @regpoly0, @corrgauss, theta, lob, upb);
%创建一个40*40的格网，标注范围为0-100，即格网间距为2.5
%S存储了点位坐标值，Y为观测值
X = gridsamp([0 0;100 100], 40);     
% X=[83.731	32.36];     %单点预测的实现
%格网点的预测值返回在矩阵YX中，预测点的均方根误差返回在矩阵MSE中
[YX,MSE] = predictor(X, dmodel);    
X1 = reshape(X(:,1),40,40); X2 = reshape(X(:,2),40,40);
YX = reshape(YX, size(X1));         %size(X1)=40*40
figure(1), mesh(X1, X2, YX)         %绘制预测表面
hold on,
plot3(x(:,1),x(:,2),Y,'.k', 'MarkerSize',10)    %绘制原始散点数据
hold off
figure(2),mesh(X1, X2, reshape(MSE,size(X1)));  %绘制每个点的插值误差大小
