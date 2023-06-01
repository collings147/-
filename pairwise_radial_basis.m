% PAIRWISE_RADIAL_BASIS - Compute the TPS radial basis function phi(r)
% between every row-pair of A and B where r is the Euclidean distance.
%
% Usage:    P = pairwise_radial_basis(A, B)
%
% Arguments:
%           A - n by d vector containing n d-dimensional points. 
%           B - m by d vector containing m d-dimensional points. 
%
% Returns:
%           P - P(i, j) = phi(norm(A(i,:)-B(j,:))) where
%                         phi(r) = r^2*log(r) for r >= 1
%                                  r*log(r^r) for r <  1
%
% References:
%           1. https://en.wikipedia.org/wiki/Polyharmonic_spline
%           2. https://en.wikipedia.org/wiki/Radial_basis_function
%
% Author:
% Daeyun Shin
% dshin11@illinois.edu  daeyunshin.com
%
% April 2014
%% 该函数接受两个输入 
%A：n1×d 的矩阵，表示第一组向量
%B：n2×d 的矩阵，表示第二组向量
%函数的输出是一个 n1×n2 的矩阵 P，其中 P(i,j) 表示第 i 个向量和第 j 个向量之间的径向基函数值
function P = pairwise_radial_basis(A, B)

% r_mat(i, j) is the Euclidean distance between A(i, :) and B(j, :).
r_mat = pdist2(A, B);%计算 A 和 B 之间的距离矩阵 r_mat

% P correcponds to the matrix A from [1].
P = zeros(size(r_mat));%根据径向基函数的定义计算 P
%对于 r_mat(i,j) 大于等于 1 的元素，将 P(i,j) 计算为 r_mat(i,j)^2 * log(r_mat(i,j))
%对于 r_mat(i,j) 小于 1 的元素，将 P(i,j) 计算为 r_mat(i,j) * log(r_mat(i,j)^r_mat(i,j))
pwise_cond_ind1 = r_mat>=1;
pwise_cond_ind2 = r_mat<1;
r_mat_p1 = r_mat(pwise_cond_ind1);
r_mat_p2 = r_mat(pwise_cond_ind2);

P(pwise_cond_ind1) = (r_mat_p1.^2) .* log(r_mat_p1);
P(pwise_cond_ind2) = r_mat_p2 .* (log(r_mat_p2.^r_mat_p2));

end
