% FIND_TPS_COEFFICIENTS - Given a set of control points and their
% displacements, compute the coefficients of the TPS interpolant f(S)
% deforming surface S.
%
% Usage:    [mapping_coeffs, poly_coeffs] = ...
%             find_tps_coefficients(control_points, displacemets, lambda);
%
% Arguments:
%           control_points - p by d vector of control points.
%           displacemets   - p by d vector of displacements of
%                            corresponding control points in the mapping
%                            function f(S).
%           lambda         - regularization parameter. See page 4 of [3].
%
% Returns:
%           mapping_coeffs - p by d vector of TPS mapping coefficients.
%           poly_coeffs    - d+1 by d vector of TPS polynomial weights.
%
% References:
%           1. http://en.wikipedia.org/wiki/Polyharmonic_spline
%           2. http://en.wikipedia.org/wiki/Thin_plate_spline
%           3. http://cseweb.ucsd.edu/~sjb/pami_tps.pdf
%
% Author:
% Daeyun Shin
% dshin11@illinois.edu  daeyunshin.com
%
% April 2014
% 计算薄板样条插值所需的映射系数和多项式系数

function [mapping_coeffs, poly_coeffs] = ...
    find_tps_coefficients(control_points, displacements, lambda)
%输入的三个参数
%control_points：n×d 的矩阵，表示控制点的坐标，其中 n 是控制点的数量，d 是坐标的维数（通常为 2 或 3）
%displacements：n×d 的矩阵，表示每个控制点对应的位移向量
%lambda：正则化参数，用于控制插值函数的平滑度
p = size(control_points, 1);
d = size(control_points, 2);

assert(isequal(size(control_points), size(displacements)), ...
    'ERROR: size(control_points) must equal size(displacements).');

% This correcponds to the matrix A from [1].
%计算径向基函数矩阵 A 
%pairwise_radial_basis 函数实现径向基函数的计算
A = pairwise_radial_basis(control_points, control_points);

% Relax the exact interpolation requirement by means of regularization. [3]
%为了避免插值函数过拟合，通过添加正则化项来平滑插值函数
%具体来说，将 A 的对角线元素加上一个正则化参数 lambda。
A = A + lambda * eye(size(A));

% This correcponds to V from [1].
V = [ones(p, 1), control_points]';

% Target points.
y = control_points + displacements;

M = [[A, V']; [V, zeros(d+1, d+1)]];
Y = [y;zeros(d+1, d)];

% solve for M*X = Y.
% At least d+1 control points should not be in a subspace; e.g. for d=2, at
% least 3 points are not on a straight line. Otherwise M will be singular.
%通过求解线性方程组 M*X = Y，得到 TPS 插值的系数矩阵 X
X = M\Y;


%函数的输出是两个矩阵
%mapping_coeffs：n×d 的矩阵，表示每个控制点对应的 TPS 插值基函数系数
%poly_coeffs：(d+1)×d 的矩阵，表示 TPS 插值中的多项式系数
mapping_coeffs = X(1:end-(d+1),:);
poly_coeffs = X((end-d):end,:);

end