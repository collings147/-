clc;clear;
load('data1.mat')
%data2=pcread('D:\����\����\bun000.ply');
%point=data2.Location;
S=data(:,1:2);
Y=data(:,3);
%ģ�Ͳ������ã���������������޸ģ���˵����
theta = [10 10]; lob = [1e-1 1e-1]; upb = [20 20];
%���캯��ģ��Ϊ��˹ģ��
[dmodel, perf] = dacefit(S, Y, @regpoly0, @corrgauss, theta, lob, upb);
%����һ��40*40�ĸ�������ע��ΧΪ0-100�����������Ϊ2.5
%S�洢�˵�λ����ֵ��YΪ�۲�ֵ
X = gridsamp([0 0;100 100], 40);     
% X=[83.731	32.36];     %����Ԥ���ʵ��
%�������Ԥ��ֵ�����ھ���YX�У�Ԥ���ľ����������ھ���MSE��
[YX,MSE] = predictor(X, dmodel);    
X1 = reshape(X(:,1),40,40); X2 = reshape(X(:,2),40,40);
YX = reshape(YX, size(X1));         %size(X1)=40*40
figure(1), mesh(X1, X2, YX)         %����Ԥ�����
hold on,
plot3(S(:,1),S(:,2),Y,'.k', 'MarkerSize',10)    %����ԭʼɢ������
hold off
figure(2),mesh(X1, X2, reshape(MSE,size(X1)));  %����ÿ����Ĳ�ֵ����С
