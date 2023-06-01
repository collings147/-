clc;clear;
close all;
load data3.mat
% x=0:0.1:10;%生成x轴
% y=0:0.1:10;%生成y轴
%z=0:0.01:1;
[X, Y] = meshgrid(x, y);
a=0;
z=f(1,:);
for i=1:length(x)
    b=1;c=1;
    for j=1:length(y)
        data(a*length(x)+b,2)=y(j);
        data(a*length(x)+b,1)=x(i);
        b=b+1;
    end
    for k=1:length(z)
        data(a*length(x)+c,3)=z(k);
        c=c+1;
    end
    a=a+1;
end
figure(1);
surf(X, Y, f);
S=data(:,1:2);
M=data(:,3);
%模型参数设置，无特殊情况不需修改，见说明书
theta = [10 10]; lob = [1e-1 1e-1]; upb = [10 10];
%变异函数模型为高斯模型
[dmodel, perf] = dacefit(S , M, @regpoly0, @corrgauss, theta, lob, upb);
%创建一个21*21的格网，标注范围为-1到1，即格网间距为0.1
%S存储了点位坐标值，Y为观测值
P = gridsamp([min(x) min(x);max(x) max(x)], 10);
%P=[83.731 32.36]; %单点预测的实现
%格网点的预测值返回在矩阵YX中，预测点的均方根误差返回在矩阵MSE中
[YX,MSE] = predictor(P, dmodel);
% [X1, Y1] = meshgrid(P(:,1), P(:,2));
% X1 = reshape(P(:,1),10,10); 
% X2 = reshape(P(:,2),10,10);
YX = reshape(YX,10,10); %size(X1)=40*40
%figure(1), mesh(X1, X2, YX) %绘制预测表面
figure(2);
surf(X1, Y1, YX);
hold on
plot3(S(:,1),S(:,2),M,'.k', 'MarkerSize',10) %绘制原始散点数据
hold off
figure(3)
surf(X1, Y1, reshape(MSE,size(X1))); %绘制每个点的插值误差大小