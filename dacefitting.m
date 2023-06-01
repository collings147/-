%% 克里金插值
function [X1,X2,YX,data]=dacefitting(x,y,f)


%% 用较多的点构造一个平面
load data5.mat
% x=0:0.1:10;%生成x轴
% y=0:0.1:10;%生成y轴
%z=0:0.01:1;
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

%% 超拉丁立方采样
%设置均值和方差，采样点数
Mu=[0.030178,0.030168]; %均值
Sigma=[0.017169,0.017169]; %方差
N = 50; % 样本点数目
D = size(Mu,2); % 维数
Covariance_Matrix = zeros(D,D);
for i = 1:D
    Covariance_Matrix(i,i) = Sigma(i)^2;
end
 
UB = Mu + 3*Sigma;
LB = Mu - 3*Sigma; % 取值范围
 
X = lhsnorm(Mu, Covariance_Matrix, N);
x1 = X(:,1);
y1 = X(:,2);
%  X = lhsnorm(Mu, Sigma, N);
figure(2);hold on;
plot(x1,y1,'*');grid on
title('正态分布的LHS采样')

%%
S=data(:,1:2);
M=data(:,3);
%模型参数设置，无特殊情况不需修改，见说明书
theta = [10 10]; lob = [1e-1 1e-1]; upb = [10 10];
%变异函数模型为高斯模型
[dmodel, perf] = dacefit(S , M, @regpoly0, @corrgauss, theta, lob, upb);
%创建一个21*21的格网，标注范围为-1到1，即格网间距为0.1
%S存储了点位坐标值，M为观测值
data1=data(:,1:2);
%P=datasample(data1,200); 
 P = gridsamp([-0.0213 -0.0213;0.0817 0.0817], 10); %给定范围内的n维网格
 
% P = gridsamp([min(x) min(x);max(x) max(x)], 5);
%P=[83.731 32.36]; %单点预测的实现
%格网点的预测值返回在矩阵YX中，预测点的均方根误差返回在矩阵MSE中
[YX,MSE] = predictor(P, dmodel); 
X1 = reshape(P(:,1),10,10); 
X2 = reshape(P(:,2),10,10);
YX = reshape(YX, size(X1)); %size(X1)=40*40
%figure(1), mesh(X1, X2, YX) %绘制预测表面
figure(3);
hold on
surf(X1, X2, YX);
plot3(data(:,1),data(:,2),data(:,3),'.k') %绘制原始散点数据 
hold off
figure(4)
axis equal;
axis([-10 10 -10 10 -0.1 0.1]);
set(gcf, 'renderer', 'opengl');
set(gca, 'CameraPosition', [-400 400 200]);
surf(X1, X2, reshape(MSE,size(X1))); %绘制每个点的插值误差大小

end