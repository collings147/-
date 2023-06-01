%% ������ֵ
function [X1,X2,YX,data]=dacefitting(x,y,f)


%% �ý϶�ĵ㹹��һ��ƽ��
load data5.mat
% x=0:0.1:10;%����x��
% y=0:0.1:10;%����y��
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
surf(X, Y, f);%%�ñȽ϶�ĵ㹹����һ������

%% ��������������
%���þ�ֵ�ͷ����������
Mu=[0.030178,0.030168]; %��ֵ
Sigma=[0.017169,0.017169]; %����
N = 50; % ��������Ŀ
D = size(Mu,2); % ά��
Covariance_Matrix = zeros(D,D);
for i = 1:D
    Covariance_Matrix(i,i) = Sigma(i)^2;
end
 
UB = Mu + 3*Sigma;
LB = Mu - 3*Sigma; % ȡֵ��Χ
 
X = lhsnorm(Mu, Covariance_Matrix, N);
x1 = X(:,1);
y1 = X(:,2);
%  X = lhsnorm(Mu, Sigma, N);
figure(2);hold on;
plot(x1,y1,'*');grid on
title('��̬�ֲ���LHS����')

%%
S=data(:,1:2);
M=data(:,3);
%ģ�Ͳ������ã���������������޸ģ���˵����
theta = [10 10]; lob = [1e-1 1e-1]; upb = [10 10];
%���캯��ģ��Ϊ��˹ģ��
[dmodel, perf] = dacefit(S , M, @regpoly0, @corrgauss, theta, lob, upb);
%����һ��21*21�ĸ�������ע��ΧΪ-1��1�����������Ϊ0.1
%S�洢�˵�λ����ֵ��MΪ�۲�ֵ
data1=data(:,1:2);
%P=datasample(data1,200); 
 P = gridsamp([-0.0213 -0.0213;0.0817 0.0817], 10); %������Χ�ڵ�nά����
 
% P = gridsamp([min(x) min(x);max(x) max(x)], 5);
%P=[83.731 32.36]; %����Ԥ���ʵ��
%�������Ԥ��ֵ�����ھ���YX�У�Ԥ���ľ����������ھ���MSE��
[YX,MSE] = predictor(P, dmodel); 
X1 = reshape(P(:,1),10,10); 
X2 = reshape(P(:,2),10,10);
YX = reshape(YX, size(X1)); %size(X1)=40*40
%figure(1), mesh(X1, X2, YX) %����Ԥ�����
figure(3);
hold on
surf(X1, X2, YX);
plot3(data(:,1),data(:,2),data(:,3),'.k') %����ԭʼɢ������ 
hold off
figure(4)
axis equal;
axis([-10 10 -10 10 -0.1 0.1]);
set(gcf, 'renderer', 'opengl');
set(gca, 'CameraPosition', [-400 400 200]);
surf(X1, X2, reshape(MSE,size(X1))); %����ÿ����Ĳ�ֵ����С

end